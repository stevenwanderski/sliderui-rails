
require 'stripe'
Stripe.api_key = 'sk_test_51Hi0fsJGhZXsnHlsXuLOdnIp83T386bgwI5WD6g7VjfkGPX5infrUuFoDQKGSStaD4Mieif31J2th6i2u5wV9kKk009YI2UTfE'

# session_id = 'cs_test_a1LwOUsyk85xGDiz0kPP57MYWEwZw3TPoUghBvAxGj14ndV9kcGEfaSiun'

# ap Stripe::Checkout::Session.retrieve(session_id)

ap Stripe::Subscription.retrieve(
  'sub_Ib0roiOUymOlsL'
)
