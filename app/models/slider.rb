# == Schema Information
#
# Table name: sliders
#
#  id         :uuid             not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Slider < ActiveRecord::Base
  has_many :slides, dependent: :destroy
end
