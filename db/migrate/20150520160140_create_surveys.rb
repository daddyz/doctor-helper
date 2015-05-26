class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :doctor_id
      t.integer :queue_number
      t.text :result
      t.boolean :shown, default: false

      t.timestamps
    end
  end
end
