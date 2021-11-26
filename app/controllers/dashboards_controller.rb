# frozen_string_literal: true

class DashboardsController < ApplicationController
  def index
    @probes = Probe.all
  end

  def show
    @probe = Probe.find(params[:id])
  end
end
