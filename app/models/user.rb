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

  # def set_token
  #   return if token.present?
  #   self.token = SecureRandom.uuid.gsub(/\-/,'')
  # end
  #
  # def set_hashed_password
  #   self.password_hash = get_hash(self.password)
  # end
end
