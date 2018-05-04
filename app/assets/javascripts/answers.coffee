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


  App.cable.subscriptions.create({ channel: 'AnswersChannel' }, {
    connected: ->
      @follow()

    follow: ->
      return unless gon.question_id
      console.log 'followed'
      @perform 'follow', id: gon.question_id

    received: (data)->
      console.log 'received'
      console.log data
      @append_try(data)

    append_try: (data)->
      html = data.body
      html += "<br/>"
      html += "<div class=\"answer_votes_"+
        data.id +
      "\""
      html += ">"
      html += data.sum
      html += "</div>"
      html += "<br/>"
      html += "<a class=\"vote_for_answer\" data-id=" +
        data.id +
        " data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/answers/" +
        data.id +
        "/like\">Vote for answer</a>"
      html += "<a class=\"vote_against_answer\" data-id=" +
        data.id +
        " data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/answers/" +
        data.id +
        "/dislike\">Vote against answer</a>"
      html += "<a class=\"unvote_answer\" data-id=" +
        data.id +
        " data-remote=\"true\" rel=\"nofollow\" data-method=\"delete\" href=\"/answers/" +
        data.id +
        "/unvote\">Delete my vote</a>"
      html += "<br/>"
      $('div.answers').append html
  })
