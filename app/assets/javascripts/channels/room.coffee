App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    $('#messages').animate
      scrollTop: $('#messages').prop('scrollHeight')
    , 500

    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#messages').append(data['message'])
    $('#messages').animate
      scrollTop: $('#messages').prop('scrollHeight')
    , 500
    $('time').timeago()

  speak: (user, message) ->
    @perform 'speak',
      message: message
      user: user


$(document).on 'keypress', '[data-behaviour~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    user = Cookies.get('user')
    if event.target.value.length > 0
      App.room.speak user, event.target.value
      event.target.value = ''
      event.preventDefault()

$(document).on 'turbolinks:load', ->
  $('#voice').focus()

  unless Cookies.get('user')
    $('#userModal').modal()

  $('#userModal').on 'hide.bs.modal', ->
    user = $('#user').val()
    Cookies.set('user', user)

  $('#user').on 'keypress', (event) ->
    if event.keyCode is 13 and event.target.value.trim().length > 0 # return = set
      $('#userModal').modal('hide')

  $('#submit').on 'click', (event) ->
    if $('#user').val().trim().length > 0
      $('#userModal').modal('hide')

  $('#voice').blur ->
    setTimeout ->
      $('#voice').focus()
    , 0
