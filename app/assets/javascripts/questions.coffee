$(window.document).ready ->
  $('a.edit_question_link').click (e)->
    e.preventDefault()

    form = $('.edit_question_form')
    question = $('.question_data')

    if (!$(this).hasClass('cancel'))
      $(this).html('Cancel')
      $(this).addClass('cancel')
    else
      $(this).html('Edit question')
      $(this).removeClass('cancel')

    form.toggle()
    question.toggle()


  $('input.submit_question_form').click ->
    $('a.edit_question_link').html('Edit question')
    form = $('.edit_question_form')
    question = $('.question_data')
    form.toggle()
    question.toggle()
