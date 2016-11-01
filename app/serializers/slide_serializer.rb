class SlideSerializer < ActiveModel::Serializer
  attributes :id, :content, :weight, :image_url

  def image_url
    object.image.url
  end
end
