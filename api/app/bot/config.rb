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
      title: 'Display Businesses',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_DISPLAY_BUSINESSES'
    },
    {
      type: 'postback',
      title: 'Display Events',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_DISPLAY_EVENTS'
    },
    {
      type: 'postback',
      title: 'Help',
      payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_HELP'
    }
  ]
)
