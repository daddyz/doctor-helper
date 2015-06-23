class SurveysController < ApplicationController
  def index
  end

  def notifiable
    render json: Survey.notifications_for_doctor(current_doctor.id,
                                                 params[:update] == 'true')
  end

  def show
    @survey = Survey.find params[:id]
    @survey.update_attributes(shown: true, notified: true)
  end

  def destroy
    survey = current_doctor.surveys.find params[:id]
    survey.destroy
    redirect_to home_dashboard_path, notice: t('controllers.surveys.destroy.survey_deleted')
  end
end