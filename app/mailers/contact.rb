class Contact < ActionMailer::Base
  default from: "ZKForever.am@gmail.com"

  def contact_email(message_params)
    @name = message_params[:name]
    @contact = message_params[:contact]
    @message = message_params[:message]
    mail(to: 'zkforever.am@gmail.com', subject: 'Question from the site.')
  end
end
