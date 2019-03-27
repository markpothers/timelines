class EmployersController < ApplicationController

  def index
    @employers = Employer.all.sort_by{ |employer| employer.people.length }.reverse
  end

  def show
    @employer = Employer.find(params[:id])
  end

  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
      if @employer.save
        redirect_to employer_path(@employer)
      else
        redirect_to new_employer_path
      end
  end

  def edit
    @employer = Employer.find(params[:id])
  end

  def update
    @employer = Employer.find(params[:id])
    @employer.update_attributes(employer_params)
    if @employer.save
      redirect_to employer_path(@employer)
    else
      redirect_to edit_employer_path(@employer)
    end
  end

  def destroy
    @employer = Employer.find(params[:id])
    @employer.destroy
    redirect_to employers_path
  end

  private

  def employer_params
    params.require(:employer).permit(:name, :description, :size, :industry, :products)
  end

end
