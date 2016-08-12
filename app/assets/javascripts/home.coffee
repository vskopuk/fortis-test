func = ->
  $.get '/phrases', (data) ->
    $(document.body).append(data + '<br/>')
    return
$ ->
  timerId = setInterval(func , 5000)