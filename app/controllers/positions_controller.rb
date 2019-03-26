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
        redirect_to new_position_path
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
    @position.update_attributes(position_params)
    if @position.save
      redirect_to position_path(@position)
    else
      redirect_to edit position_path(@position)
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    redirect_to positions_path
  end

  private

  def position_params
    params.require(:position).permit(:title, :start_date, :finish_date, :person_attributes => [:name], :employer_attributes => [:name], :city_attributes => [:name])
  end

  # def person_params
  #   params.require(:position).require(:person).permit(:name)
  # end

end
