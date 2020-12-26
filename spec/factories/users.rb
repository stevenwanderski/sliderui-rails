FactoryGirl.define do
  factory :user do
    email { 'frank@zappa.com' }
    password { 'testtest' }
    confirmed { true }
    subscription_type { 'free' }
    subscription_status { 'active' }
    stripe_customer_id { nil }

    trait :premium do
      stripe_customer_id { 'cus_123' }
      subscription_type { 'premium' }
      subscription_status { 'active' }
    end
  end
end
