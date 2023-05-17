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
#  stripe_subscription_id :string
#  trial_ends_at          :datetime
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

  def active?
    ['subscribed', 'trial'].include?(subscription_status)
  end

  def set_free_trial!
    update!(
      trial_ends_at: 14.days.from_now,
      subscription_status: 'trial'
    )
  end

  def subscribed?
    subscription_status == 'subscribed'
  end

  def trial_days
    return if trial_ends_at.blank?

    (trial_ends_at - Time.now).seconds.in_days.ceil
  end

  def trial?
    subscription_status == 'trial'
  end

  def self.days_to_expire(days)
    User.where('trial_ends_at < ? AND trial_ends_at > ?', (days+1).days.from_now, (days-1).days.from_now)
  end
end
