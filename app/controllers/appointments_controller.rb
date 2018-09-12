class AppointmentsController < ApplicationController
  before_action :find_appointment, only: %i[edit update destroy]
  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(appointment_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @appointment.destroy
    redirect_to root_url
  end

  private

  def find_appointment
    @appointment = Appointment.find_by(id: params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date,
                                        :patient_id,
                                        :doctor_id)
  end
end
