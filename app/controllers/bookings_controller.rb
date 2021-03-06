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
    @now = Date.today
    @booking = Booking.new(booking_params)
    @booking.tool = Tool.find(params[:tool_id])
    @booking.user = current_user
    if @booking.start_date >= @now && @booking.start_date <= @booking.end_date && @booking.save
      redirect_to dashboard_path
    else
      redirect_to tool_path(@booking.tool)
      flash.now[:notice] = "A problem has occurred while processing your booking."
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboard_path
  end

  private 

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
