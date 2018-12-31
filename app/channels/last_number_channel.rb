class LastNumberChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'last_number'
  end
end
