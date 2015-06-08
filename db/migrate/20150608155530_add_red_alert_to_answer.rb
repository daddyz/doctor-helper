class AddRedAlertToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :red_alert, :boolean, default: false
  end
end
