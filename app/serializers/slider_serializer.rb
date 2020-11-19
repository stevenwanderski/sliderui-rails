class SliderSerializer < ActiveModel::Serializer
  attributes :id, :title, :settings, :short_code, :display_image_url

  has_many :slides

  def display_image_url
    return nil if object.slides.empty?

    object.slides.order(weight: :asc).first.image.url
  end
end
