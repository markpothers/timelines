class PositionsController < ApplicationController

  def index
    @positions = Position.all
  end

  def show
     @position = Position.find(params[:id])
  end

  def new
     @position = Position.new
  end

  def create
     @position = Position.new
      if @position.save
        redirect_to position_path(@position)
      else
        redirect_to new_position_path
      end
  end

  def edit
    @position = Position.find(params[:id])
  end

  def update
    @position = Position.find(params[:id])
    @position.update_attributes(position_params)
    if Position.save
      redirect_to position_path(@position)
    else
      redirect_to edit position_path(@position)
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    redirect_to index
  end

  private

  def position_params
    params.require(position).permit(:title, :start_date, :finish_date, :person_id, :employer_id, :city_id)
  end

end
