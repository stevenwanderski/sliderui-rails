query = TrackLog.all

total = query.count

"Resetting #{total} counters..."

query.find_each.with_index do |track_log, index|

  # next if track_log.slider.track_logs_count != nil

  Slider.reset_counters(track_log.slider.id, :track_logs)

  if index % 1000 == 0
    ap "#{index} / #{total} completed..."
  end
end

ap "Finished resetting #{total} counters."