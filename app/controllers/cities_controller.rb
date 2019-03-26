class CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
      if @city.save
        redirect_to city_path(@city)
      else
        redirect_to new_city_path
      end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    @city.update_attributes(city_params)
    if @city.save
      redirect_to city_path(@city)
    else
      redirect_to edit_city_path(@city)
    end
  end

  def destroy
    @city = City.find(params[:id])
    @city.destroy
    redirect_to cities_path
  end

  private

  def city_params
    params.require(:city).permit(:name, :region, :country)
  end

end
