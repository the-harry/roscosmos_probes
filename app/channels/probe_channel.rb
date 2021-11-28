# frozen_string_literal: true

class ProbeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "probe_channel_#{params[:probe_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
