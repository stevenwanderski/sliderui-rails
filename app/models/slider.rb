# == Schema Information
#
# Table name: sliders
#
#  id           :uuid             not null, primary key
#  title        :string
#  user_id      :uuid
#  temp_user_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Slider < ActiveRecord::Base
  has_many :slides, dependent: :destroy
  belongs_to :user

  before_create :set_temp_user_id

  private

  def set_temp_user_id
    self.temp_user_id = SecureRandom.uuid if user.nil?
  end
end
