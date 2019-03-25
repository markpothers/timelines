class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
      if @person.save
        redirect_to person_path(@person)
      else
        redirect_to new_person_path
      end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    @person.update_attributes(person_params)
    if @person.save
      redirect_to person_path(@person)
    else
      redirect_to edit_person_path(@person)
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to index
  end

  private

  def person_params
    params.require(:person).permit(:name, :birthday)
  end

end
