class CustomDeviseMailer < Devise::Mailer
  include SendGrid
  include Rails.application.routes.url_helpers
  default from: 'manuel.sanchez3.1416@gmail.com'
  
  def confirmation_instructions(record, token, opts={})
    @token = token
    mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: 'manuel.sanchez3.1416@gmail.com')
    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: record.email))
    mail.add_personalization(personalization)
    mail.subject = 'Confirm your account'
    content = "
    <p>Welcome #{record.email}!</p>

    <p>You can confirm your account email through the link below:</p>

    <p><a href='#{user_confirmation_url(record, confirmation_token: @token, format: :html)}'>Confirm my account</a></p>
    "

    # Añadir el contenido al correo electrónico
    mail.add_content(SendGrid::Content.new(type: 'text/html', value: content))

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._('send').post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
  end

  def reset_password_instructions(record, token, opts={})
    @token = token
    mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: 'manuel.sanchez3.1416@gmail.com')
    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: record.email))
    mail.add_personalization(personalization)
    mail.subject = 'Reset Password'
    content = "
    <p>Hello #{record.email}!</p>

    <p>Someone has requested a link to change your password. You can do this through the link below.</p>
    
    <p><a href='#{edit_user_password_url(record, reset_password_token: @token)}'>Change my password</a></p>
    
    <p>If you didn't request this, please ignore this email.</p>
    <p>Your password won't change until you access the link above and create a new one.</p>
    "

    # Añadir el contenido al correo electrónico
    mail.add_content(SendGrid::Content.new(type: 'text/html', value: content))

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._('send').post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
  end
end
