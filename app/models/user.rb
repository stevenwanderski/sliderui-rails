# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  email      :string
#  password   :string
#  token      :string
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  before_create :set_token
  before_save :set_hashed_password, if: :password_changed?

  has_many :sliders, dependent: :destroy

  validates :email, uniqueness: { allow_blank: true }

  private

  def set_token
    return if token.present?
    self.token = SecureRandom.uuid.gsub(/\-/,'')
  end

  def set_hashed_password
    self.password = Digest::SHA2.new(512).hexdigest(self.password)
  end
end
