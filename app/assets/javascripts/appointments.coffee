# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  # gotten from Semantic (https://semantic-ui.com/collections/message.html)
  $('body').closest('.message').transition 'fade 1s'
  $('.message .close').on 'click', ->
    $(this).closest('.message').transition 'fade'
    return
  return
