class Recipe < ApplicationRecord
  include ActiveModel::Serialization

  has_one_attached :photo do |attachable|
      attachable.variant :thumb, resize_to_limit: [ 100, 100 ], preprocessed: true
  end

  def photo_url
    Rails.application.routes.url_helpers.url_for(photo) if photo.attached?
  end

  def thumb_url
    return unless photo.attached?
    thumb = photo.variant(:thumb)
    Rails.application.routes.url_helpers.url_for(thumb)
  end
end
