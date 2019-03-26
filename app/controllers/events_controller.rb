class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
     @event = Event.find(params[:id])
  end

  def new
     @event = Event.new
  end

  def create
     @event = Event.new
      if @event.save
        redirect_to event_path(@event)
      else
        redirect_to new_event_path
      end
  end

  def edit
    @event = Event.find(params[:id])
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
    params.require(event).permit(:title, :start_date, :finish_date, :person_id, :description, :city_id)
  end

end
