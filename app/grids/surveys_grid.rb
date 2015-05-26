class SurveysGrid
  include Datagrid

  scope do
    Survey.where('1 <> 1')
  end

  filter :shown

  column '', html: true do |survey|
    content_tag(:span, 'new', class: 'label label-success') unless survey.shown?
  end
  column :queue_number
  column :created_at
  column :actions, html: true do |survey|
    [
      link_to('View Survey', survey_path(survey), class: 'btn btn-sm btn-default'),
      link_to('Delete Survey', survey_path(survey), confirm: 'Are you sure?', class: 'btn btn-sm btn-danger', method: :delete),
    ].join(' ').html_safe
  end

  def initialize(attributes = {})
    @current_doctor = attributes[:current_doctor]

    super(attributes.except(:current_doctor))
  end

  def scope
    if @current_doctor
      @current_doctor.surveys
    else
      super
    end
  end
end