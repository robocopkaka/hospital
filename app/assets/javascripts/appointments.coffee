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

  # code for user appointment history
  headers = document.getElementsByClassName("menu-header")
  const past = $(headers[0]).hasClass("site-green")
  const future = $(headers[1]).hasClass("site-green")
  $(headers[0]).addClass "site-green"
  $(headers[0]).hover (->
    if ($(headers[0]).hasClass("site-green")) && !$(headers[1]).hasClass("site-green")
      $(headers[0]).toggleClass "site-green"
#      $(headers[1]).addClass("menu-header").removeClass "site-green"
    else if ($(headers[0]).hasClass("site-green"))
      $(headers[0]).toggleClass "site-green"
    return
  ), ()-> (
    if (past)
      $(headers[0]).toggleClass("site-green")
    else if (future)
      $(headers[1]).toggleClass("site-green")
    return
  )

  $(headers[1]).hover (->
    if ($(headers[0]).hasClass("site-green")) && !$(headers[1]).hasClass("site-green")
      $(headers[0]).toggleClass "site-green"
      $(headers[1]).toggleClass "site-green"
#      $(headers[1]).addClass("menu-header").removeClass "site-green"
    else if ($(headers[1]).hasClass("site-green"))
      $(headers[1]).toggleClass "site-green"
    return
  ), ()-> (
    if (future)
      $(headers[1]).toggleClass("site-green")
    else if (past)
      $(headers[0]).toggleClass("site-green")
    return
  )
  console.log(headers)
  return

