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
      p_info = position_params(:title,:person,:employer,:city,"start_date(1i)","start_date(2i)","start_date(3i)","finish_date(1i)","finish_date(2i)","finish_date(3i)")
      @position.start_date = Date.new(p_info["start_date(1i)"].to_i,p_info["start_date(2i)"].to_i,p_info["start_date(3i)"].to_i)
      @position.finish_date = Date.new(p_info["finish_date(1i)"].to_i,p_info["finish_date(2i)"].to_i,p_info["finish_date(3i)"].to_i)
      @position.update_attributes(title: p_info[:title], person: p_info[:person], employer: p_info[:employer], city: p_info[:city])
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

<<<<<<< HEAD
  def position_params(*args)
    params.require(:position).permit(*args)
=======
  def position_params
    params.require(:position).permit(:title, :start_date, :finish_date, :person_attributes => [:name], :employer_attributes => [:name], :city_attributes => [:name])
    # params.require(:position).permit(:title, :start_date, :finish_date, :person => [:name], :employer => [:name], :city => [:name])
>>>>>>> 4508329cc54680576f843dca985904c06b782342
  end

  # def start_date_from_params
  #   info = params.require(:position).permit("start_date(1i)", "start_date(2i)", "start_date(3i)")
  #   return Date.new(info[:position]["start_date(1i)"].to_i,info[:position]["start_date(2i)"].to_i,info[:position]["start_date(3i)"].to_i)
  # end

  # def finish_date_from_params
  #   info = params.require(:position).permit("finish_date(1i)", "finish_date(2i)", "finish_date(3i)")
  #   return Date.new(info[:position]["finish_date(1i)"].to_i,info[:position]["finish_date(2i)"].to_i,info[:position]["finish_date(3i)"].to_i)
  # end

end
