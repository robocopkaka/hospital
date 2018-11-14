# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#specialization-pagination-links').bind 'click', (event) ->
    window.scrollTo 0,0
    $('.ui.stackable.three.column.grid').html '<div class="ui segment"><p></p><div class="ui active inverted dimmer centered inline"><div class="ui massive loader"></div></div></div>'
    return
  return