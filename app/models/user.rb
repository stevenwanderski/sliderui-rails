# == Schema Information
#
# Table name: users
#
#  id                    :uuid             not null, primary key
#  email                 :string
#  encrypted_password    :string
#  encrypted_password_iv :string
#  token                 :string
#  confirmed             :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class User < ActiveRecord::Base
  attr_encrypted :password, key: 'b304ce596d11cb573492b75dc382fef4997bc76bdca4e0d3'

  before_create :set_token

  has_many :sliders

  validates :email, uniqueness: { allow_blank: true }

  private

  def set_token
    return if token.present?
    self.token = SecureRandom.uuid.gsub(/\-/,'')
  end
end
