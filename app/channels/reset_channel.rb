class ResetChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'reset'
  end
end
