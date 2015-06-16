ActiveAdmin.register Answer do

  permit_params :question_id, :body_en, :body_ru, :body_he, :red_alert

  form do |f|
    f.inputs 'Answer' do
      f.input :question, include_blank: false
      f.input :body_en
      f.input :body_ru
      f.input :body_he
      f.input :red_alert
    end
    f.actions
  end

  index do
    column :id
    column :question
    column :body
    column :followups do |answer|
      if answer.answer_followups.present?
        answer.answer_followups.map do |followup|
          followup.questions.map do |question|
            link_to question.to_s, admin_question_path(question)
          end.join('<br>').html_safe
        end.join('<br>').html_safe
      end
    end
    column :red_alert

    actions
  end

  action_item only: :show do
    link_to 'Link to Questions', new_admin_answer_followup_path(answer_followup: { answer_id: resource.id })
  end
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
