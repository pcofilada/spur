Bot.on :message do |message|
  if message.sender['id'] != '168331146959068'
    if message.quick_reply
      case message.quick_reply
      when 'BUSINESS_QUICK_REPLY', 'LOAD_MORE_BUSINESS_YES'
        businesses = Business.order("RANDOM()").limit(10)

        business_response(businesses, message)
        load_more_businesses(message)
      when 'LOAD_MORE_BUSINESS_NO'
        end_conversation(message)
      end
    else
      find_business(message)
    end
  end
end

private

  def business_response(businesses, message)
    Bot.deliver(
      recipient: { id: message.sender['id'] },
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

  def find_business(message)
    if message.text.include? 'Find a business that caters '
      selector = /(?<=\ caters\s)(\w+)/.match(message.text)
      identifier = message.text.slice!(selector[1])
      businesses = Business.where("'#{identifier}' = ANY (services)").order("RANDOM()").limit(10)
    elsif message.text.include? 'Find a business located at '
      selector = /located at (.*)/.match(message.text)
      identifier = message.text.slice!(selector[1])
      businesses = Business.where("location like ?", "%#{identifier}%").order("RANDOM()").limit(10)
    end

    business_response(businesses, message)
  end

  def load_more_businesses(message)
    Bot.deliver(
      recipient: { id: message.sender['id'] },
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

  def end_conversation(message)
    Bot.deliver(
      recipient: { id: message.sender['id'] },
      message: {
        text: 'Just message us if you need something and we will help you find it.'
      }
    )
  end
