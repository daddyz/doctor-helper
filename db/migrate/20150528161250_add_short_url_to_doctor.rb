class AddShortUrlToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :short_url, :string
  end
end
