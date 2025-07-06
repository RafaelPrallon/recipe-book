class RecipeSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :category, :ingredients, :instructions, :preparation_time, :photo_url, :thumb_url
end
