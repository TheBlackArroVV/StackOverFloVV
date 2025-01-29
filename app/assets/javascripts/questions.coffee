$(window.document).ready ->
  questions = $('div.questions')

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

  $('a.vote_for_question').bind 'ajax:success', (e) ->
    $('.votes').html(e.detail[0])
    $('.question_errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.question_errors').html(e.detail[0])

  $('a.vote_against_question').bind 'ajax:success', (e) ->
    $('.votes').html(e.detail[0])
    $('.question_errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.question_errors').html(e.detail[0])

  $('a.unvote').bind 'ajax:success', (e) ->
    $('.votes').html(e.detail[0])
    $('.question_errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.question_errors').html(e.detail[0])

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow'

    received: (data)->
      console.log data
      questions.append data
  })

