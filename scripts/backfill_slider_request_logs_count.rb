query = Slider.where('request_logs_count IS NULL')

total = query.count

"Resetting #{total} counters..."

query.find_each.with_index do |slider, index|

  Slider.reset_counters(slider.id, :request_logs)

  if index % 1000 == 0
    ap "#{index} / #{total} completed..."
  end
end

ap "Finished resetting #{total} counters."