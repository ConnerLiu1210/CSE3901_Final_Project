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
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip.id), notice: "Trip was successfully created."
    else
      # Returning the appropriate HTTP status code (422) when validation fails
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id), notice: "Trip was successfully created."
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
