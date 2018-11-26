# frozen_string_literal: true

# contains methods fot the appointment controller
class AppointmentsController < ApplicationController
  include AppointmentsHelper
  before_action :find_appointment, only: %i[edit update destroy decline_appointment]
  attr_accessor :specialization_id
  def new
    @appointment = Appointment.new
  end

  # flash keys - positive, error (using Semantic)

  def create
    @appointment = current_patient.appointments.build(appointment_params)
    # binding.pry
    if @appointment.save
      AppointmentMailer.with(appointment: @appointment)
                       .new_appointment.deliver_later
      redirect_to root_path, success: 'Your appointment was created successfully'
    else
      render 'new'
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment.status = 'confirmed'
    if @appointment.update_attributes(appointment_params)
      AppointmentMailer.with(appointment: @appointment)
                       .confirm_appointment.deliver_later
      redirect_to pending_appointments_path,
                  info: 'Appointment updated successfully'
    else
      render 'edit'
    end
    # @appointment.update_attributes(confirmed: true)
  end

  # def approve
  #   if params[:admin]
  #     confirm_appointment(@appointment)
  #   end
  # end

  def pending_appointments
    @appointments = Appointment.pending
                               .paginate(page: params[:page], per_page: 4)
  end

  def decline_appointment
    # @appointment.status = 'declined'
    if @appointment.update_attributes(status: 'declined')
      AppointmentMailer.with(appointment: @appointment)
                       .decline_appointment.deliver_later
      redirect_to pending_appointments_path,
                  info: 'Appointment declined successfully'
    end
  end

  def destroy
    @appointment.destroy
    redirect_to root_path, danger: 'Appointment deleted successfully'
  end

  private

  def find_appointment
    @appointment = Appointment.find_by(id: params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date,
                                        :specialization_id, :doctor_id)
  end
end
