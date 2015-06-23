class AddNotifiedToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :notified, :boolean, default: false
  end
end
