jQuery ->
  $("a[rel~=popover], .has-popover").popover({html: true, container: 'body' })
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  $('#notificationPopover').on 'hidden.bs.popover', ->
    $('#notificationPopover').attr('data-content', 'No New Notifications')

  $('#notificationPopover').on 'shown.bs.popover', ->
    $('#notificationPopover > span').removeClass('label-primary').addClass('label-default')
    $('#notificationPopover > span > b').html(0)
    $.get '/surveys/notifiable?update=true'