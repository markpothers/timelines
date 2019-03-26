class EventsController < ApplicationController

  def index
    @events = Event.all
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
     @event = Event.new(event_params)
      if @event.save
        redirect_to event_path(@event)
      else
        redirect_to new_event_path
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
    params.require(:event).permit(:title, :start_date, :finish_date, :description, :visitor => [:name], :destination => [:name])
  end

end
