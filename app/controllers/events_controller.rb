class EventsController < ApplicationController

  def index
    @events = Event.all.sort_by{ |event| event.start_date }
  end

  def show
     @event = Event.find(params[:id])
  end

  def new
     @event = Event.new
     @cities = City.all
     @people = Person.all
  end

  def create
    byebug
    @event = event.new
    @event.start_date = get_start_date
    @event.finish_date = get_finish_date
    @event.update_attributes(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
end


  def edit
    @event = Event.find(params[:id])
    @cities = City.all
    @people = Person.all
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(event_params)
    if event.save
      redirect_to event_path(@event)
    else
      redirect_to edit event_path(@event)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:visitor, :title, :description, :destination,"start_date(1i)","start_date(2i)","start_date(3i)","finish_date(1i)","finish_date(2i)","finish_date(3i)")
  end

  def get_start_date
    p_info = position_params
    start = Date.new(p_info["start_date(1i)"].to_i,p_info["start_date(2i)"].to_i,p_info["start_date(3i)"].to_i)
  end

  def get_finish_date
    p_info = position_params
    return Date.new(p_info["finish_date(1i)"].to_i,p_info["finish_date(2i)"].to_i,p_info["finish_date(3i)"].to_i)
  end

end
