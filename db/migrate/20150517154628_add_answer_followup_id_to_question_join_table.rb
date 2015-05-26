class AddAnswerFollowupIdToQuestionJoinTable < ActiveRecord::Migration
  def change
    create_join_table :answer_followups, :questions, column_options: {null: true}
  end
end
