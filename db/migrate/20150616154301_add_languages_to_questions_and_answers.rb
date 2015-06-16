class AddLanguagesToQuestionsAndAnswers < ActiveRecord::Migration
  def change
    rename_column :questions, :body, :body_en
    add_column :questions, :body_ru, :text
    add_column :questions, :body_he, :text

    rename_column :answers, :body, :body_en
    add_column :answers, :body_ru, :text
    add_column :answers, :body_he, :text
  end
end
