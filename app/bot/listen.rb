include Facebook::Messenger
require 'facebook/messenger'
require_relative './config'
require_relative './postback'
require_relative './message'

Facebook::Messenger::Subscriptions.subscribe
