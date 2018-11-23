class DoctorsController < ApplicationController
  include DoctorsHelper
  before_action :find_doctor,
                only: %i[edit update_password show destroy appointments]
  before_action :redirect_unless_admin, only: :destroy
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      DoctorMailer.with(doctor: @doctor).update_password.deliver_later
      redirect_to doctors_url, success: 'Doctor was created successfully'
    else
      render 'new'
    end
  end

  def edit; end

  def update_password
    if @doctor.update_with_password(doctor_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in @doctor, scope: :doctor
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
    redirect_to root_path
  end

  def appointments
    @appointments = @doctor.appointments
  end

  private

  def doctor_params
    params.require(:doctor).permit(
      :name, :email, :specialization_id, :password, :password_confirmation,
      :current_password
    )
  end

  def find_doctor
    @doctor = Doctor.find_by(id: params[:id]) || current_doctor
    # @doctor = Doctor.find_by(id: params[:id])
  end

  def redirect_unless_admin
    redirect_to root_url unless current_doctor.admin
  end
end