class SurveysController < ApplicationController
  def index
  end

  def show
    @survey = Survey.find params[:id]
    @survey.update_attribute(:shown, true)
  end

  def destroy
    survey = current_doctor.surveys.find params[:id]
    survey.destroy
    redirect_to home_dashboard_path, notice: 'Survey deleted!'
  end
end