class CitiesController < ApplicationController
  require 'similar_text'

  def home
  end

  def search
    @query = params[:query]
    @cities = City.where('name LIKE ?', "%#{@query}%")
    @people = Person.where('name LIKE ?', "%#{@query}%")
    @employers = Employer.where('name LIKE ?', "%#{@query}%")
    @positions = Position.where('title LIKE ?', "%#{@query}%")
    @events = Event.where('title LIKE ?', "%#{@query}%")
    @results = []
    if @people != [] then @results << @people end 
    if @cities != [] then @results << @cities end
    if @employers != [] then @results << @employers end
    if @positions != [] then @results << @positions end
    if @events != [] then @results << @events end
    @results = @results.flatten.sort_by{|result| result.class.to_s == "Event" || result.class.to_s == "Position" ? result.title.similar(params[:query]) : result.name.similar(params[:query])}.reverse
  end

  def index
    @cities = City.all.sort_by{ |city| city.people.length }.reverse
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
        render :new
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
