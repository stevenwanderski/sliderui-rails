class SlideSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :content, :weight, :image_url, :destroy_url

  def image_url
    object.image.url
  end

  def thumb_url
    object.image.url
  end

  def destroy_url
    api_slide_path(object)
  end
end
