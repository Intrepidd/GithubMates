# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.load_google_maps = ->
  mapOptions = {
      center: new google.maps.LatLng(40, 0),
      zoom: 2,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  map = new google.maps.Map($('#google_maps')[0], mapOptions)
  window.geocoder = new google.maps.Geocoder()

  addresses = ['16 Willbrook Lawn, Rathfarnam', 'Orsay, France', 'Bordeaux', 'Nantes', 'Strasbourg']

  $.each(addresses, (index, address)->
    geocoder.geocode({ 'address' : address }, (results, status)->
      if status == google.maps.GeocoderStatus.OK
        marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          animation: google.maps.Animation.DROP
        })
    )
  )


