class SettlementsController < ApplicationController
  before_action :require_login

  def show
    @trip = Trip.find(params[:trip_id])
    @balances    = @trip.members.map { |u| [u, @trip.net_balance(u)] }
    @settlements = @trip.settlements
  end
end
