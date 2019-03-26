class PositionsController < ApplicationController

  def index
    @positions = Position.all
  end

  def show
      @position = Position.find(params[:id])
  end

  def new
<<<<<<< HEAD
      @position = Position.new
=======
     @position = Position.new
     @employer = Employer.new
     @position.employer = @employer
     @person = Person.new
     @position.person = @person
     @city = City.new
     @position.city = @city
     @employers = Employer.all
     @cities = City.all
     @people = Person.all
>>>>>>> bb197d8f5b0bfb561a4a630e697e0f485c4c8a30
  end

  def create
      @position = Position.new
      if @position.save
        redirect_to position_path(@position)
      else
        render :new
      end
  end

  def edit
    @position = Position.find(params[:id])
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
<<<<<<< HEAD
    params.require(position).permit(:title, :start_date, :finish_date, :person_id, :employer_id, :city_id)
=======
    params.require(:position).permit(:title, :start_date, :finish_date, :person_attributes => [:name], :employer_attributes => [:name], :city_attributes => [:name])
    # params.require(:position).permit(:title, :start_date, :finish_date, :person => [:name], :employer => [:name], :city => [:name])
>>>>>>> bb197d8f5b0bfb561a4a630e697e0f485c4c8a30
  end

end
