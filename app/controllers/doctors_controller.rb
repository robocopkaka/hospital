class DoctorsController < ApplicationController
  before_action :find_doctor, only: %i[edit update show destroy appointments]
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if @doctor.update_attributes(doctor_params)
      redirect_to root_url
    end
  end

  def index
    @doctors = Doctor.all
  end

  def show; end

  def destroy
    @doctor.destroy
    redirect_to root_url
  end

  def appointments
    @appointments = @doctor.appointments
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :email)
  end

  def find_doctor
    @doctor = Doctor.find_by(id: params[:id])
  end
end
