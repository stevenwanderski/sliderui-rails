# == Schema Information
#
# Table name: request_logs
#
#  id         :integer          not null, primary key
#  slider_id  :uuid
#  user_id    :uuid
#  referrer   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RequestLog < ActiveRecord::Base
  belongs_to :slider, counter_cache: true
  belongs_to :user
end
