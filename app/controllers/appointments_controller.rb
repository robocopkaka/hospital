# frozen_string_literal: true

# contains methods fot the appointment controller
class AppointmentsController < ApplicationController
  before_action :find_appointment, only: %i[edit update destroy]
  attr_accessor :specialization_id
  def new
    @appointment = Appointment.new
  end

  # flash keys - positive, error (using Semantic)

  def create
    @appointment = current_patient.appointments.build(appointment_params)
    if @appointment.save
      AppointmentMailer.with(appointment: @appointment)
                       .new_appointment.deliver_later
      redirect_to root_url
      flash[:success] = 'Your appointment was created successfully'
    else
      flash[:error] = 'Looks like your appointment had some errors'
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
                                        :specialization_id)
  end
end
