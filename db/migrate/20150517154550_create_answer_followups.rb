class CreateAnswerFollowups < ActiveRecord::Migration
  def change
    create_table :answer_followups do |t|
      t.integer :answer_id

      t.timestamps
    end
  end
end
