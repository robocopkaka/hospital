class PatientsController < ApplicationController
  before_action :find_patient, only: %i[show edit update destroy appointments]
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patient_url(@patient)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @patient.update_attributes(patient_params)
      redirect_to patient_url(@patient)
    else
      render 'edit'
    end
  end

  def show; end

  def index
    @patients = Patient.all
  end

  def destroy
    @patient.destroy
    redirect_to root_url
  end

  def appointments
    @appointments = @patient.appointments
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :email, :address)
  end

  def find_patient
    @patient = Patient.find_by(id: params[:id])
  end
end
