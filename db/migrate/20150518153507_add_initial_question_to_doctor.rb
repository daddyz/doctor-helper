class AddInitialQuestionToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :initial_question_id, :integer
  end
end
