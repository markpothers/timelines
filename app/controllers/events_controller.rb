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
    @event = Event.new(event_params)
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
    if @event.save
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:destination, :visitor, :title, :description, "start_date(1i)", "start_date(2i)", "start_date(3i)", "finish_date(1i)", "finish_date(2i)", "finish_date(3i)")
  end

end
