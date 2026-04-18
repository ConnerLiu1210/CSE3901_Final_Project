class ExpensesController < ApplicationController
  before_action :require_login
  before_action :set_trip
  before_action :require_member
  before_action :set_expense, only: [:edit, :update, :destroy]

  def new
    @expense = @trip.expenses.new(date: Date.today, category: "General")
  end

  def create
    @expense = @trip.expenses.new(expense_params)
    @expense.user_id = current_user.id

    if @expense.save
      split_ids = params[:expense][:participant_ids].to_a.map(&:to_i).reject(&:zero?)
      split_ids = @trip.members.pluck(:id) if split_ids.empty?
      @expense.split_evenly_among(split_ids)

      redirect_to @trip, notice: "Expense added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      split_ids = params[:expense][:participant_ids].to_a.map(&:to_i).reject(&:zero?)
      split_ids = @trip.members.pluck(:id) if split_ids.empty?
      @expense.split_evenly_among(split_ids)

      redirect_to @trip, notice: "Expense updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to @trip, notice: "Expense removed."
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_expense
    @expense = @trip.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:description, :amount, :date, :category)
  end

  def require_member
    unless @trip.members.include?(current_user)
      redirect_to trips_path, alert: "You are not a participant in this trip."
    end
  end
end
