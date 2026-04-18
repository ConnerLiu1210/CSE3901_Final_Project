class TripsController < ApplicationController
  before_action :require_login
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_member, only: [:show]
  before_action :require_creator, only: [:edit, :update, :destroy]

  def index
    @trips = current_user.trips
  end

  def show
    @expenses   = @trip.expenses.order(date: :desc)
    @balances   = @trip.members.map { |u| [u, @trip.net_balance(u)] }
    @settlements = @trip.settlements
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id

    if @trip.save
      @trip.trip_memberships.create!(user_id: current_user.id)

      participant_ids = params[:trip][:participant_ids].to_a.map(&:to_i).reject(&:zero?)
      participant_ids.each do |uid|
        @trip.trip_memberships.find_or_create_by!(user_id: uid)
      end

      redirect_to @trip, notice: "Trip created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      existing_ids = @trip.trip_memberships.pluck(:user_id)
      new_ids = params[:trip][:participant_ids].to_a.map(&:to_i).reject(&:zero?)
      new_ids << current_user.id

      (existing_ids - new_ids).each { |uid| @trip.trip_memberships.find_by(user_id: uid)&.destroy }
      (new_ids - existing_ids).each { |uid| @trip.trip_memberships.find_or_create_by!(user_id: uid) }

      redirect_to @trip, notice: "Trip updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, notice: "Trip deleted."
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date)
  end

  def require_member
    unless @trip.members.include?(current_user)
      redirect_to trips_path, alert: "You are not a participant in this trip."
    end
  end

  def require_creator
    unless @trip.creator == current_user
      redirect_to @trip, alert: "Only the trip creator can do that."
    end
  end
end
