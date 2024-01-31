class CustomerSerializer
  include JSONAPI::Serializer 

  attributes :first_name
  attributes :last_name
  attributes :email
  attributes :address
end