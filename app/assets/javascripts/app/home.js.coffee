messages = []
no_messages_text = ''
getNotifications = ->
  $.getJSON '/surveys/notifiable', (data)->
    if data.length > 0
      label = $('#notificationPopover span.label')

      if !label.hasClass('label-primary')
        label.addClass('label-primary')

      $.each data, (i)->
        if messages.indexOf(data[i]) >= 0
          return
        else
          messages.push data[i]

        counter = $('#notificationPopover b')
        counter.html(parseInt(counter.html()) + 1)

        content = $('#notificationPopover').attr('data-content')
        if no_messages_text == ''
          no_messages_text = content
        if content.indexOf('</ul>') != -1
          content = content.replace('</ul>', '<li>' + data[i] + '</li></ul>')
        else
          content = '<ul class=\'list-unstyled\'><li>' + data[i] + '</li></ul>'
        $('#notificationPopover').attr('data-content', content)

getNotifications()
setInterval getNotifications, 5000