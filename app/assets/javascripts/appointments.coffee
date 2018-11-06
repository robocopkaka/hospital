# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  # gotten from Semantic (https://semantic-ui.com/collections/message.html)
  $('body').closest('.message').transition 'fade 1s'
  $('#pagination-links').bind 'click', (event) ->
    window.scrollTo 0,0
    $('.ui.stackable.two.column.grid').html '<div class="ui segment"><p></p><div class="ui active inverted dimmer centered inline"><div class="ui massive loader"></div></div></div>'
    return
  $('.message .close').on 'click', ->
    $(this).closest('.message').transition 'fade'
    return

  doctor = document.getElementById('appointment_doctor_id')
  if doctor
    $('#appointment_specialization_id').prop 'disabled', true
    $('#appointment_appointment_date').prop 'disabled', true
  return
