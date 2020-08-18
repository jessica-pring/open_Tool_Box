class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @tool = Tool.find(params[:tool_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.tool = Tool.find(params[:tool_id])
    @booking.user = current_user
    if @booking.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path(current_user)
  end

  private 

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
