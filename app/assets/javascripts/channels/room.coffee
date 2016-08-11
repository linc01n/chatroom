App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#messages').append(data['message'])

  speak: (user, message) ->
    @perform 'speak',
      message: message
      user: user


$(document).on 'keypress', '[data-behaviour~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    user = Cookies.get('user')
    App.room.speak user, event.target.value
    event.target.value = ''
    event.preventDefault()

$(document).on 'turbolinks:load', ->
  $('#userModal').modal() unless Cookies.get('user')

  $('#userModal').on 'hide.bs.modal', ->
    user = $('#user').val()
    Cookies.set('user', user)

  $('#user').on 'keypress', (event) ->
    if event.keyCode is 13 # return = set
      $('#userModal').modal('hide')
