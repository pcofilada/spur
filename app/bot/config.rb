Facebook::Messenger::Thread.set(
  setting_type: 'call_to_actions',
  thread_state: 'new_thread',
  call_to_actions: [
    {
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_WELCOME'
    }
  ]
)

Facebook::Messenger::Thread.set(
  setting_type: 'call_to_actions',
  thread_state: 'existing_thread',
  call_to_actions: [
    {
      type: 'postback',
      title: 'Find a Business',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_FIND_BUSINESS'
    },
    {
      type: 'postback',
      title: 'Find an Event',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_FIND_AN_EVENT'
    },
    {
      type: 'postback',
      title: 'Help',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_HELP'
    }
  ]
)
