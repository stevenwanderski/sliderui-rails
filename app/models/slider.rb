class Slider < ActiveRecord::Base
  has_many :slides, dependent: :destroy
end
