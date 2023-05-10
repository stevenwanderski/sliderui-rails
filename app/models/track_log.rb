# == Schema Information
#
# Table name: track_logs
#
#  id         :bigint(8)        not null, primary key
#  short_code :string
#  url        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slider_id  :uuid
#
class TrackLog < ActiveRecord::Base
  belongs_to :slider, counter_cache: true
end
