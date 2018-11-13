class SpecializationsController < ApplicationController
  before_action :find_specialization, only: %i[edit update destroy]
  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = Specialization.new(specialization_params)
    if @specialization.save
      redirect_to specializations_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @specialization.update_attributes(specialization_params)
      redirect_to specializations_url
    else
      render 'edit'
    end
  end

  def index
    @specializations = Specialization.all
  end

  def destroy
    @specialization.destroy
    redirect_to root_url
  end

  private

  def specialization_params
    params.require(:specialization).permit(:name)
  end

  def find_specialization
    @specialization = Specialization.find_by(id: params[:id])
  end
end
