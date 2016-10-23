Bot.on :message do |message|
  if message.sender['id'] != '168331146959068'
    if message.quick_reply
      case message.quick_reply
      when 'BUSINESS_QUICK_REPLY'
        business_response(message)
        load_more_businesses(message)
      end
    else
      find_business(message)
    end
  end
end

private

  def business_response(message)
    Bot.deliver(
      recipient: { id: message.sender['id'] },
      message: {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: [
              {
                title: 'Welcome to Peter\'s Hats',
                item_url: 'https://petersfancybrownhats.com',
                image_url: 'http://lorempixel.com/400/200/',
                subtitle: 'We\'ve got the right hat for everyone.',
                buttons: [
                  {
                    type: 'web_url',
                    url: 'https://wanderly.co',
                    title: 'Visit Website'
                  },
                  {
                    type: 'web_url',
                    url: 'https://www.facebook.com/wanderly.co',
                    title: 'Visit Page'
                  },
                  {
                    type: 'phone_number',
                    title: 'Call',
                    payload: '+639102819266'
                  }
                ]
              }
            ]
          }
        }
      }
    )
  end

  def find_business(message)

    if message.text.include? 'Find a business that offers '
      selector = /(?<=\offers\s)(\w+)/.match(message.text)
    elsif message.text.include? 'Find a business located at '
      selector = /located at (.*)/.match(message.text)
    end

    identifier = message.text.slice!(selector[1])
    business_response(message)
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
            payload: 'LOAD_MORE_BUSINESS_YES'
          }
        ]
      }
    )
  end
