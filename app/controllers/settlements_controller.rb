class SettlementsController < ApplicationController
  before_action :authorized

  def show
    @trip = current_user.trips.find_by_id(params[:trip_id])
    unless @trip
      flash[:alert] = "Trip not found."
      redirect_to trips_path and return
    end
    @balances    = @trip.users.map { |u| [u, @trip.net_balance(u)] }
    @settlements = @trip.settlements
  end
end
