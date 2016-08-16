window.token = 'fake'

func = ->
  $.ajax(
    url: "/phrases"
    type: "GET"
    headers:
      "Authorization": "Token token=#{window.token}"
    dataType: "html").done (data, textStatus, jqXHR) ->
      window.token = jqXHR.getResponseHeader("Authorization")
      $(document.body).append(data + "<br/>")
    return
$ ->
  timerId = setInterval(func , 10000)