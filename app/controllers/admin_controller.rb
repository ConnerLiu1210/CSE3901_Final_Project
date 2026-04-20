class AdminController < ApplicationController
  def dashboard
    @trips = Trip.all.order(created_at: :desc)
  end

end