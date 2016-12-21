module ImageHelper
  def test_image_path
    File.join(Rails.root, 'spec', 'support', 'images', 'dags.jpg')
  end
end
