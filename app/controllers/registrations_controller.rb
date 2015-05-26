class RegistrationsController < Devise::RegistrationsController
  before_filter :set_sign_up_parameters, :only => [:create]
  before_filter :set_update_parameters, :only => [:update]

  def update
    data = account_update_params
    result = if data[:password]
               current_doctor.update_with_password(data)
             else
               current_doctor.update_without_password(data)
             end
    if result
      redirect_to home_dashboard_path, notice: 'Profile updated!'
    else
      render :edit
    end
  end

  protected

  def set_update_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      if params[:doctor][:password].empty?
        u.permit(:first_name, :last_name)
      else
        u.permit(:first_name, :last_name, :password, :password_confirmation,
                 :current_password)
      end

    end
  end

  def set_sign_up_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
