class PositionsController < ApplicationController

  def index
    @positions = Position.all
  end

  def show
      @position = Position.find(params[:id])
  end

  def new
    @position = Position.new
    @employers = Employer.all
    @cities = City.all
    @people = Person.all
  end

  def create
      @position = Position.new(position_params)
      if @position.save
        redirect_to position_path(@position)
      else
        render :new
      end
  end

  def edit
    @position = Position.find(params[:id])
    @employers = Employer.all
    @cities = City.all
    @people = Person.all
  end

  def update
    @position = Position.find(params[:id])
    if @position.update(position_params)
      redirect_to position_path(@position)
    else
      render :edit
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    redirect_to index
  end

  private

  def position_params
    params.require(:position).permit(:title, :start_date, :finish_date, :person_attributes => [:name], :employer_attributes => [:name], :city_attributes => [:name])
    # params.require(:position).permit(:title, :start_date, :finish_date, :person => [:name], :employer => [:name], :city => [:name])
  end

end
