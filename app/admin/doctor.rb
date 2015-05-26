ActiveAdmin.register Doctor do

  permit_params :email, :first_name, :last_name, :password,
                :initial_question_id

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :initial_question do |doctor|
      Question.where(id: doctor.initial_question_id).first.try(:to_s)
    end
    actions
  end

  form do |f|
    f.inputs 'Doctor Profile' do
      f.input :email
      f.input :password
      f.input :first_name
      f.input :last_name
    end

    f.inputs 'Survey Settings' do
      f.input :initial_question_id, as: :select, collection: Question.all,
              include_blank: false
    end

    f.actions
  end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  controller do
    def update
      if params[:doctor][:password].blank?
        params[:doctor].except! :password
      end
      super
    end
  end
end
