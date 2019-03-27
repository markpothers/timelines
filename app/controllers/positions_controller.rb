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
      @position = Position.new
      @position.start_date = get_start_date
      @position.finish_date = get_finish_date
      @position.update_attributes(position_params)
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
    @position.start_date = get_start_date
    @position.finish_date = get_finish_date
    @position.update_attributes(position_params)
    if @position.save(position_params)
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
    params.require(:position).permit(:title,:person,:employer,:city,"start_date(1i)","start_date(2i)","start_date(3i)","finish_date(1i)","finish_date(2i)","finish_date(3i)")
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
