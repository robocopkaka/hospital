# frozen_string_literal: true

require 'will_paginate/array'
# contains methods fot the appointment controller
class AppointmentsController < ApplicationController
  include AppointmentsHelper
  before_action :find_appointment, only: %i[edit update destroy decline_appointment]
  before_action :logged_in_user, only: %i[appointment_history past_appointments future_appointments]
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

  def appointment_history
    # binding.pry
    appointments = @logged_in_user.appointments.where(status: :confirmed)
    appointments_hash = HashWithIndifferentAccess.new
    appointments_hash[:past_appointments] = []
    appointments_hash[:future_appointments] = []
    @appointments = group_appointments(appointments, appointments_hash)
  end

  def past_appointments
    @appointments = {}
    query = 'status = ? AND appointment_date < ?'
    @appointments[:past_appointments] = @logged_in_user.appointments
                                                       .where(query, :confirmed,
                                                              Time.now)
    @appointments[:past_appointments] = @appointments[:past_appointments]
                                        .paginate(page: params[:page],
                                                  per_page: 3)
    @appointments
  end

  def future_appointments
    @appointments = {}
    query = 'status = ? AND appointment_date > ?'
    @appointments[:future_appointments] = @logged_in_user.appointments
                                                         .where(query,
                                                                :confirmed,
                                                                Time.now)
    @appointments[:future_appointments] = @appointments[:future_appointments]
                                          .paginate(page: params[:page],
                                                    per_page: 6)
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
