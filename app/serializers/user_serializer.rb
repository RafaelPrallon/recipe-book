class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :avatar_url, :thumb_url
end
