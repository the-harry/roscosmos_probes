# frozen_string_literal: true

class Api::V1::ProbesController < Api::V1::ApiController
  def create
    probe = Probe.create!(probe_params)

    render json: probe, status: :created
  end

  private

  def probe_params
    params.permit(:name, :cosmonaut, :x, :y, :direction)
  end
end
