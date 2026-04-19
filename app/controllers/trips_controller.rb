class TripsController < ApplicationController
  before_action :authorized
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = current_user.trips
  end

  def show
    if @trip.nil?
      flash[:alert] = "Trip not found!"
      redirect_to trips_path
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params.except(:user_ids))
    selected_ids = Array(params.dig(:trip, :user_ids)).map(&:to_i).reject(&:zero?)
    selected_ids |= [current_user.id]
    if @trip.save
      @trip.user_ids = selected_ids
      redirect_to trip_path(@trip.id), notice: "Trip was successfully created."
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    selected_ids = Array(params.dig(:trip, :user_ids)).map(&:to_i).reject(&:zero?)
    selected_ids |= [current_user.id]
    if @trip.update(trip_params.except(:user_ids))
      @trip.user_ids = selected_ids
      redirect_to trip_path(@trip.id), notice: "Trip was successfully updated."
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, alert: "Trip was successfully deleted."
  end

  private

  def trip_params
    params.require(:trip).permit(:trip_name, :start_date, :end_date, user_ids: [])
  end

  def set_trip
    @trip = current_user.trips.find_by_id(params[:id])
  end
end
