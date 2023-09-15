class WhatsappNotificationService
  require 'rubygems'
  require 'twilio-ruby'

  def initialize(phone_number, message)
    @phone_number = phone_number
    @message = message
  end

  def send
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']

  begin
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    message = @client.messages.create(
      body: @message,
      from: 'whatsapp:+14155238886',
      to: "whatsapp:#{@phone_number}"
    )
  rescue Twilio::REST::RestError => e
    puts "Error sending message: #{e.message}"
  end
end
