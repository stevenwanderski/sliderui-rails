# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string
#  password_hash          :string
#  token                  :string
#  confirmed              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  subscription_type      :string
#  stripe_customer_id     :string
#  subscription_status    :string
#  is_legacy              :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sliders, dependent: :destroy

  def active_premium?
    subscription_type == 'premium' && subscription_status == 'active'
  end

  def can_add_slider?
    return true if active_premium?

    sliders.count < Subscription.get_max_slider_count('free')
  end

  def sliders_restricted
    return Slider.none if active_premium?

    offset = Subscription.get_max_slider_count('free')
    sliders.order(created_at: :desc).offset(offset)
  end

  def sliders_unrestricted
    return sliders if active_premium?

    limit = Subscription.get_max_slider_count('free')
    sliders.order(created_at: :desc).limit(limit)
  end

  def update_to_premium!(stripe_customer_id)
    update!(
      subscription_type: 'premium',
      subscription_status: 'active',
      stripe_customer_id: stripe_customer_id
    )
  end

  def update_to_free!
    update!(
      subscription_type: 'free',
      subscription_status: 'active'
    )
  end

  def valid_password?(password)
    if self.password_hash.present?
      if get_hash(password) == self.password_hash
        self.password = password
        self.password_hash = nil
        self.save!
        true
      else
        false
      end
    else
      super
    end
  end

  private

  def get_hash(string)
    Digest::SHA2.new(512).hexdigest(string)
  end
end
