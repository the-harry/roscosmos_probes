# frozen_string_literal: true

class Api::V1::ProbesController < Api::V1::ApiController
  before_action :find_probe, only: %i[travel_home current_position run_commands]

  def create
    probe = Probe.create!(probe_params)

    render json: probe, status: :created
  end

  def travel_home
    @probe.travel_home!

    render json: @probe, status: :ok
  end

  def current_position
    render json: @probe.current_position, status: :ok
  end

  def run_commands
    output = CommandsExecutorService.call(@probe, params[:commands])

    render json: output, status: :ok
  end

  private

  def probe_params
    params.permit(:name, :cosmonaut, :x, :y, :direction)
  end

  def find_probe
    @probe = Probe.find(params[:id])
  end
end
