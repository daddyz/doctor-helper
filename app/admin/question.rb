ActiveAdmin.register Question do

  permit_params :body_en, :body_ru, :body_he

  action_item only: :show do
    link_to 'Add Answer', new_admin_answer_path(answer: { question_id: resource.id })
  end

  index do
    column :id
    column :body
    column :answers do |question|
      question.answers.map do |answer|
        link_to answer.to_s, admin_answer_path(answer)
      end.join('<br>').html_safe
    end

    actions
  end

end
