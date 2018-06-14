function autocompleteActivityDepartureLocation() {
  document.addEventListener("DOMContentLoaded", function() {
    var departureLocation = document.getElementById('activity_departure_location');

    if (departureLocation) {
      var autocomplete = new google.maps.places.Autocomplete(departureLocation, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(departureLocation, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocompleteActivityDepartureLocation };


function autocompleteTourStoreAddress() {
  document.addEventListener("DOMContentLoaded", function() {
    var departureLocation = document.getElementById('tour_store_address');

    if (departureLocation) {
      var autocomplete = new google.maps.places.Autocomplete(departureLocation, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(departureLocation, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocompleteTourStoreAddress };

