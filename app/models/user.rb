class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
      attachable.variant :thumb, resize_to_limit: [ 100, 100 ], preprocessed: true
  end

  def avatar_url
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def thumb_url
    return unless avatar.attached?
    thumb = avatar.variant(:thumb)
    Rails.application.routes.url_helpers.url_for(thumb)
  end
end
