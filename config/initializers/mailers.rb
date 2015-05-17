DoctorHelper::Application.config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: 'localhost',
    port: 1025
}