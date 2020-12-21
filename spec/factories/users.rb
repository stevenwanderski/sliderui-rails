FactoryGirl.define do
  factory :user do
    email { 'frank@zappa.com' }
    password { 'testtest' }
    confirmed { true }
    subscription_type { 'free' }
    subscription_status { 'active' }
    stripe_customer_id { nil }
  end
end
