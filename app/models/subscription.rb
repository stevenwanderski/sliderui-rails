class Subscription
  PLANS = {
    free: {
      cost: 0,
      label: 'Free'
    },

    premium: {
      cost: 5,
      label: 'Premium 🏆'
    }
  }.with_indifferent_access

  def self.get_plan(type)
    return type if PLANS.keys.include?(type)

    'free'
  end

  def self.get_cost(type)
    plan = get_plan(type)

    PLANS[plan][:cost]
  end

  def self.get_label(type)
    plan = get_plan(type)

    PLANS[plan][:label]
  end
end
