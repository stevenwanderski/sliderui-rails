# == Schema Information
#
# Table name: sliders
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  title      :string
#  short_code :string
#  settings   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sliders_on_short_code  (short_code) UNIQUE
#

class Slider < ActiveRecord::Base
  has_many :slides, dependent: :destroy
  belongs_to :user

  before_create :set_short_code

  validates :title, presence: true

  def display_image_url
    return nil if slides.empty?

    slides.order(weight: :asc).first.image.url
  end

  private

  def set_short_code
    self.short_code = loop do
      random_short_code = ('a'..'z').to_a.shuffle[0,6].join
      break random_short_code unless Slider.exists?(short_code: random_short_code)
    end
  end
end
