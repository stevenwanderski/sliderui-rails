class Subscription
  PLANS = {
    free: {
      cost: 0,
      label: 'Free',
      max_slider_count: ENV['FREE_SLIDER_MAX'].to_i
    },

    premium: {
      cost: 5,
      label: 'Premium 🏆',
      max_slider_count: nil
    }
  }.with_indifferent_access

  def self.get_cost(type)
    plan = get_plan(type)

    PLANS[plan][:cost]
  end

  def self.get_label(type)
    plan = get_plan(type)

    PLANS[plan][:label]
  end

  def self.get_max_slider_count(type)
    plan = get_plan(type)

    PLANS[plan][:max_slider_count]
  end

  def self.get_plan(type)
    return type if PLANS.keys.include?(type)

    'free'
  end
end
