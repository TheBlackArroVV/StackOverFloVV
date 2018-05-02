# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window.document).ready ->
  $('a.edit_answer_link').click (e)->
    e.preventDefault()

    answer_id = $(this).data('answerId')

    $(this).hide()
    $('form#edit_answer_' + answer_id).show()

  $('input.submit_edit_answer_form').click ->
    $('a.edit_answer_link').html('Edit answer')
    answer_id = $(this).data('answerId')
    form = $('form#edit_answer_' + answer_id)
    form.toggle()
