Bot.on :postback do |postback|
  case postback.payload
  when 'DEVELOPER_DEFINED_PAYLOAD_FOR_WELCOME'
    welcome_response(postback)
  when 'DEVELOPER_DEFINED_PAYLOAD_FOR_HELP'
    help_response(postback)
  when 'DEVELOPER_DEFINED_PAYLOAD_FOR_DISPLAY_BUSINESSES'
    businesses = Business.published.order("RANDOM()").limit(10)

    business_response(businesses, postback)
    load_more_businesses(postback)
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

  def business_response(businesses, postback)
    Bot.deliver(
      recipient: { id: postback.sender['id'] },
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: render_businesses(businesses)
          }
        }
      }
    )
  end

  def render_businesses(businesses)
    rendered_businesses = []
    businesses.each do |business|
      rendered_businesses << {
        title: business.name,
        item_url: business.website,
        image_url: business.image,
        subtitle: business.description,
        buttons: [
          {
            type: 'web_url',
            url: business.website,
            title: 'Visit Website'
          },
          {
            type: 'web_url',
            url: business.facebook_page,
            title: 'Visit Page'
          },
          {
            type: 'phone_number',
            title: 'Call',
            payload: business.contact_number
          }
        ]
      }
    end

    return rendered_businesses
  end

  def load_more_businesses(postback)
    Bot.deliver(
      recipient: { id: postback.sender['id'] },
      message: {
        text: 'Load more businesses?',
        quick_replies: [
          {
            content_type: 'text',
            title: 'Yes Please',
            payload: 'LOAD_MORE_BUSINESS_YES'
          },
          {
            content_type: 'text',
            title: 'No Thanks',
            payload: 'LOAD_MORE_BUSINESS_NO'
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
    • Find a business that caters foods
    • Find a business located at Pasig, Philippines
    • Find an event near Eastwood City
    • Find an event that will be happening on June 12, 2016"
  end
