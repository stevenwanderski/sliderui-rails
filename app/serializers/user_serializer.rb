class UserSerializer < ActiveModel::Serializer
  attributes :email, :token, :confirmed
end
