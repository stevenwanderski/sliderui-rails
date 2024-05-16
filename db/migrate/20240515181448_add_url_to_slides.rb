class AddUrlToSlides < ActiveRecord::Migration[7.0]
  def change
    add_column :slides, :url, :text
  end
end
