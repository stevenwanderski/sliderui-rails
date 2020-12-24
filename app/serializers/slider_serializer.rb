class SliderSerializer < ActiveModel::Serializer
  attributes :id, :title, :settings, :short_code, :display_image_url
  has_many :slides
end
