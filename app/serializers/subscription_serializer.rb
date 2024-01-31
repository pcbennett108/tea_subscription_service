class SubscriptionSerializer
  include JSONAPI::Serializer 

  attributes :title
  attributes :price
  attributes :frequency
  attributes :sub_status
  attributes :customer_id
  attributes :tea_id

end