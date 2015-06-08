class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
    if params[:locale]
      session[:locale] = params[:locale]
    end
    if session[:locale].nil?
      session[:locale] = get_locale_from_accept_language_header
    end
    I18n.locale = session[:locale]
  end

  private

  def get_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
