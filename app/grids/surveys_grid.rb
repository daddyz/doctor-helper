class SurveysGrid
  include Datagrid

  scope do
    Survey.where('1 <> 1')
  end

  filter :shown

  column '', html: true do |survey|
    flags = []
    flags << content_tag(:span, I18n.t('grids.surveys.new_survey_tag'), class: 'label label-success') unless survey.shown?
    flags << content_tag(:span, I18n.t('grids.surveys.alert_survey_tag'), class: 'label label-danger') if survey.red_alert?

    flags.join(' ').html_safe
  end
  column :queue_number, header: I18n.t('grids.surveys.columns.queue_number')
  column :created_at, header: I18n.t('grids.surveys.columns.created_at')
  column :actions, header: I18n.t('grids.surveys.columns.actions'), html: true do |survey|
    [
      link_to(I18n.t('grids.surveys.links.view_survey'), survey_path(survey), class: 'btn btn-sm btn-default'),
      link_to(I18n.t('grids.surveys.links.delete_survey'), survey_path(survey), data: { confirm: I18n.t('grids.surveys.links.are_you_sure') }, class: 'btn btn-sm btn-danger', method: :delete),
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