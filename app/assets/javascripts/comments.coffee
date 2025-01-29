$(window.document).ready ->
  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      @perform 'follow'

    received: (data)->
      if data.commentable_type == 'Question'
        comments = $('div.question_comments')
        comments.append data.body
        comments.append("<br/>")
      else
        comments = $('div.answer_' + data.commentable_id + '_comments')
        console.log 'div.answer_' + data.commentable_id + '_comments'
        comments.append data.body
        comments.append("<br/>")
  })