$(window.document).ready ->
  answers = $('div.answers')

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

  $('a.vote_for_answer').bind 'ajax:success', (e) ->
    id = $(this).data('id')
    $('.answer_votes_' + id).html(e.detail[0])
    $('.errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.errors').html(e.detail[0])

  $('a.vote_against_answer').bind 'ajax:success', (e) ->
    id = $(this).data('id')
    $('.answer_votes_' + id).html(e.detail[0])
    $('.errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.errors').html(e.detail[0])

  $('a.unvote_answer').bind 'ajax:success', (e) ->
    id = $(this).data('id')
    $('div.answer_votes_' + id).html(e.detail[0])
    $('.errors').html = ''
  .bind 'ajax:error', (e) ->
    $('.errors').html(e.detail[0])


  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'connected'
      @perform 'follow'
      ,

    received: (data)->
      answers.append data
  })
