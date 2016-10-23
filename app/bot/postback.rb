Bot.on :postback do |postback|
  case postback.payload
  when 'DEVELOPER_DEFINED_PAYLOAD_FOR_WELCOME'
    welcome_response(postback)
  when 'DEVELOPER_DEFINED_PAYLOAD_FOR_HELP'
    help_response(postback)
  end
end

private
  
  def welcome_response(postback)
    Bot.deliver(
      recipient: { id: postback.sender['id'] },
      message: {
        text: 'What are you looking for?',
        quick_replies: [
          {
            content_type: 'text',
            title: 'Business',
            payload: 'BUSINESS_QUICK_REPLY'
          },
          {
            content_type: 'text',
            title: 'Event',
            payload: 'EVENT_QUICK_REPLY'
          }
        ]
      }
    )
  end

  def help_response(postback)
    Bot.deliver(
      recipient: { id: postback.sender['id'] },
      message: {
        text: help_message
      }
    )
  end

  def help_message
    "Hi there. So I can find things that you need. Tell me things like the following:

    • Show all businesses
    • Show all events
    • Find a business that offers foods
    • Find a business located at Pasig, Philippines
    • Find an event near Eastwood City
    • Find an event that will be happening on June 12, 2016"
  end
