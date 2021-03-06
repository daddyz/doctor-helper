class HomeController < ApplicationController
  before_filter :set_doctor, only: [:survey, :survey_step]

  def index
  end

  def dashboard
    @surveys = SurveysGrid.new({current_doctor: current_doctor, shown: false})
  end

  def instructions
  end

  def qr_code
    respond_to do |format|
      format.png do
        send_data current_doctor.qr_code, type: 'image/png',
                  filename: 'qr_code.pnh', disposition: 'inline'
      end
    end
  end

  def survey
    @questions = Question.where(id: session[:survey]['answers'].keys).
        map(&:with_answers)
  end

  def survey_step
    if params[:a] != '0'
      session[:survey]['answers'][params[:q]] = params[:a]
      already_answered = session[:survey]['answers'].keys.map(&:to_i)
      session[:survey]['questions'] +=
          AnswerFollowup.following_questions(params[:a]) - already_answered
      session[:survey]['questions'].uniq!
    end

    next_id = next_survey_question
    Survey.add_from_session(session[:survey]) if next_id.nil?
    render json: next_id.nil? ? {} : Question.find(next_id).with_answers.merge(session: session[:survey])
  end

  def init
    @doctor = Doctor.where(id: params[:doc]).first
    if @doctor.nil?
      redirect_to root_path, alert: t('controllers.home.init.wrong_url_specified')
      return
    end
    if params[:q]
      session[:survey] = {
          doctor: @doctor.id,
          queue: params[:q],
          questions: [],
          answers: {}
      }
      redirect_to home_survey_path
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find session[:survey]['doctor']
  end

  def next_survey_question
    return 1 unless session[:survey]

    if session[:survey]['questions'].empty?
      return @doctor.initial_question_id
    end

    (session[:survey]['questions'] - session[:survey]['answers'].keys.map(&:to_i)).first
  end
end
