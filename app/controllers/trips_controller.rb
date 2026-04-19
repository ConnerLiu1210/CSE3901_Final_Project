class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = set_trip
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
    @trip = set_trip
  end

  def update
    @trip = set_trip
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id), notice: "Trip was successfully created."
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def delete
    @trip = set_trip
    @trip.delete
    redirect_to trips_path, alert: "Trip was successfully deleted."
  end

   private
    def trip_params
      params.require(:trip).permit(:trip_name, :start_date, :end_date, participants: [])
    end

    def set_trip
      @trip = Trip.find_by_id(params[:id])
    end
end
