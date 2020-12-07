FactoryGirl.define do
  factory :request_log do
    slider
    user
    referrer "https://some/url"
  end
end
