# == Schema Information
#
# Table name: sliders
#
#  id                 :uuid             not null, primary key
#  user_id            :uuid
#  title              :string
#  short_code         :string
#  settings           :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  request_logs_count :integer
#  width              :string           default("1600")
#  height             :string           default("250")
#  mode               :string           default("linear")
#  speed              :string           default("500")
#  auto_enabled       :boolean          default(FALSE)
#  auto_interval      :string           default("2000")
#  controls_enabled   :boolean          default(TRUE)
#  pager_enabled      :boolean          default(TRUE)
#  version            :integer
#  track_logs_count   :integer
#
# Indexes
#
#  index_sliders_on_short_code  (short_code) UNIQUE
#

class Slider < ActiveRecord::Base
  has_many :slides, -> { order(weight: :asc) }, dependent: :destroy
  has_many :request_logs
  has_many :track_logs
  belongs_to :user

  before_create :set_short_code

  def v2?
    self.version == 2
  end

  private

  def set_short_code
    self.short_code = loop do
      random_short_code = ('a'..'z').to_a.shuffle[0,6].join
      break random_short_code unless Slider.exists?(short_code: random_short_code)
    end
  end
end
