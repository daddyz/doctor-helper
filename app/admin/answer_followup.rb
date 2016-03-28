ActiveAdmin.register AnswerFollowup do

  permit_params :answer_id, question_ids: []

  index do
    column :id
    column :question do |followup|
      q = followup.answer.question
      link_to q.to_s, admin_question_path(q)
    end
    column :answer
    column :following_questions do |followup|
      followup.questions.map do |q|
        link_to q.to_s, admin_question_path(q)
      end.join('<br>').html_safe
    end
    actions
  end

  form do |f|
    f.inputs "Answer to Question \"#{f.object.answer.question.to_s}\" Relations" do
      f.input :answer, collection: f.object.answer.question.answers, selected: f.object.answer_id, include_blank: false
      f.input :question_ids, as: :check_boxes, collection: Question.where('id != ?', f.object.answer.question.id)
      actions
    end
  end
end
