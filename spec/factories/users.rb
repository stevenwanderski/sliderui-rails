FactoryBot.define do
  factory :user do
    email { 'frank@zappa.com' }
    password { 'testtest' }
    confirmed { true }
    status { 'active' }
    stripe_customer_id { nil }
  end
end
