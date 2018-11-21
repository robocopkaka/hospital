class DoctorsController < ApplicationController
  include DoctorsHelper
  before_action :find_doctor,
                only: %i[edit update_password show destroy appointments]
  before_action :redirect_unless_admin, only: :destroy
  # new method
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      DoctorMailer.with(doctor: @doctor).update_password.deliver_later
      redirect_to doctors_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @doctor.update_attributes(doctor_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def index
    @doctors = Doctor.all
  end

  def show; end

  def destroy
    reassign_appointments(@doctor) if doctor_has_appointments?(@doctor)
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
