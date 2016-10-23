class BotController < ApplicationController

  def webhook
    if params['hub.verify_token'] == 'spur_is_what_i_need'
      render text: params['hub.challenge'] and return
    else
      render text: 'error' and return
    end
  end

  def receive_message
    if params[:entry]
      messaging_events = params[:entry][0][:messaging]
      messaging_events.each do |event|
        sender = event[:sender][:id]
        if (text = event[:message] && event[:message][:text])
          send_text_message(sender, "Hi there! You said: #{text}. The Bots")
        end
      end
    end
    render nothing: true
  end

private

  def send_text_message(sender, text)
    body = {
      recipient: {
        id: sender
      },
      message: {
        text: text
      }
    }.to_json

    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=EAAQK0LVk83MBAH7t5E83FTvQ0u2M3iOEpuDZBZAtEErBc4NqFao9e4Fm5JyAEIalgeoxpNKWihxsghlj9busL7GRZCZAL2C6tgQwgRUqVAlrZBaZBV1rUwCnSksA1WPQU5NfkG5jxyRXDDKEQK8o6Q5XC09aDrm77qrJhTEZBorWQZDZD",
      body: body,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
