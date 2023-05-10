query = TrackLog.where('slider_id IS NULL')

total = query.count

"Backfilling #{total} track logs..."

query.find_each.with_index do |track_log, index|

  slider = Slider.find_by(short_code: track_log.short_code)
  track_log.update_column(:slider_id, slider.id)

  if index % 1000 == 0
    ap "#{index} / #{total} completed..."
  end
end

ap "Finished backfilling #{total} track logs."