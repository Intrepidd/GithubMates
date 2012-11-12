# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require handlebars.runtime
//= require_tree ./templates

window.infos = []

window.close_info_windows = ->
  $.each(window.infos, (index, w)->
    w.close()
  )
  window.infos = []

window.load_google_maps = ->
  mapOptions = {
      center: new google.maps.LatLng(40, 0),
      zoom: 2,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  window.map = new google.maps.Map($('#google_maps')[0], mapOptions)
  window.geocoder = new google.maps.Geocoder()

  google.maps.event.addListener(map, 'click', ->
    close_info_windows()
  )

window.add_users_to_map = (user, repository)->

  bar = $('#progress_bar div')
  $.getJSON("/api/mates?user=#{user}&repository=#{repository}", (data) ->

    i = 0

    other_users = []

    $.each(data, (index, user)->
      if (user.location != undefined)
        geocoder.geocode({ 'address' : user.location }, (results, status)->
          if status == google.maps.GeocoderStatus.OK
            marker = new google.maps.Marker({
              map: window.map,
              position: results[0].geometry.location,
              animation: google.maps.Animation.DROP
            })

            google.maps.event.addListener(marker, 'click', ->
              close_info_windows()
              info = new google.maps.InfoWindow({
                content: HandlebarsTemplates['bubble'](user)
              })
              info.open(map, marker)
              window.infos.push info
            )

        )
        # User w/out localisation, add it to the users that will go in the table
        other_users.push user
      i += 1
      # Update the progress bar
      bar.css({width: "#{i / data.length * 100}%"})
    )
    $('#progress_bar').removeClass('active')
    if other_users.length > 0
      $('#other_users').html(HandlebarsTemplates['table']({users : other_users}))
  )

