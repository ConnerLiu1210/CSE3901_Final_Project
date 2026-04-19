class ExpensesController < ApplicationController
  before_action :authorized
  before_action :set_trip
  before_action :set_expense, only: [:destroy]

  def new
    @expense = Expense.new
  end

  def create
    @expense = @trip.expenses.build(expense_params)
    split_ids = Array(params.dig(:expense, :split_user_ids)).map(&:to_i).reject(&:zero?)
    split_ids = @trip.users.pluck(:id) if split_ids.empty?

    if @expense.save
      @expense.split_evenly_among(split_ids)
      redirect_to trip_path(@trip), notice: "Expense added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to trip_path(@trip), notice: "Expense removed."
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount, :date, :category, :user_id)
  end

  def set_trip
    @trip = current_user.trips.find_by_id(params[:trip_id])
    unless @trip
      flash[:alert] = "Trip not found."
      redirect_to trips_path
    end
  end

  def set_expense
    @expense = @trip.expenses.find_by_id(params[:id])
    unless @expense
      flash[:alert] = "Expense not found."
      redirect_to trip_path(@trip)
    end
  end
end
