# == Schema Information
#
# Table name: track_logs
#
#  id         :bigint(8)        not null, primary key
#  short_code :string
#  url        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TrackLog < ActiveRecord::Base
end
