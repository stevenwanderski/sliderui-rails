# == Schema Information
#
# Table name: slides
#
#  id         :uuid             not null, primary key
#  slider_id  :uuid             not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Slide < ActiveRecord::Base
  belongs_to :slider
end
