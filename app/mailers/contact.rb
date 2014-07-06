class Contact < ActionMailer::Base
  # default from: "ZKForever.am@gmail.com"

  def contact_email(message_params)
    @name = message_params[:name]
    @email = message_params[:email]
    @message = message_params[:message]
    subject = message_params[:subject]
    mail(to: 'zkforever.am@gmail.com', subject: message_params[:subject], from: message_params[:email])
  end
end
