# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window.document).ready ->
  $('.find_button').bind 'ajax:success', (e) ->
    console.log('success')
    .bind 'ajax:error', (e) ->
    $('.question_errors').html(e.detail[0])