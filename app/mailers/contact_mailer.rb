class ContactMailer < ApplicationMailer
  def new_message(first_name, last_name, email, message)
    @first_name = first_name
    @last_name  = last_name
    @email = email
    @message = message

    mail(
      to: "yanbuxes@gmail.com",
      reply_to: email,
      subject: "New contact message from #{first_name} #{last_name}"
    ) do |format|
      format.text { render plain: "From: #{@first_name} #{@last_name}\n\n#{@message}" }
      format.html { render html: "<p><strong>From:</strong> #{@first_name} #{@last_name}</p><p>#{ERB::Util.html_escape(@message).gsub(/\n/, '<br>')}</p>".html_safe }
    end
  end
end
