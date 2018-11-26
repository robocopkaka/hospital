class SpecializationsController < ApplicationController
  before_action :find_specialization, only: %i[edit update destroy]
  before_action :admin?, only: :destroy
  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = Specialization.new(specialization_params)
    if @specialization.save
      redirect_to specializations_path,
                  success: 'Specialization added successfully'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @specialization.update_attributes(specialization_params)
      redirect_to specializations_url,
                  info: 'Specialization updated successfully'
    else
      render 'edit'
    end
  end

  def index
    @specializations = Specialization.all.paginate(page: params[:page], per_page: 6)
  end

  def destroy
    @specialization.destroy
    redirect_to root_path
  end

  private

  def specialization_params
    params.require(:specialization).permit(:name)
  end

  def find_specialization
    @specialization = Specialization.find_by(id: params[:id])
  end

  def admin?
    return if current_doctor.admin?
    redirect_to root_path, danger: 'Hey, you\'re not an admin'
  end
end
