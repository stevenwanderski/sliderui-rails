# == Schema Information
#
# Table name: slides
#
#  id         :uuid             not null, primary key
#  slider_id  :uuid             not null
#  content    :text
#  weight     :integer          default(0), not null
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url        :text
#

class Slide < ActiveRecord::Base
  belongs_to :slider
  mount_uploader :image, SlideImageUploader

  validates :image, presence: true

  validates :url, url: {
    allow_blank: true,
    message: 'must include http:// or https://'
  }
end
