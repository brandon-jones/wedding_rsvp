class FlaggedGuestbook < ActionMailer::Base
  default from: "ZKForever.am@gmail.com"

  def flagged_notifier
    mail(to: 'zkforever.am@gmail.com', subject: 'A Message has been flagged')
  end
end
