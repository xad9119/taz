// app/javascript/packs/map.js
import GMaps from 'gmaps/gmaps.js';


// function callback(results, status) {
//   if (status == google.maps.places.PlacesServiceStatus.OK) {
//     for (var i = 0; i < results.length; i++) {
//       var place = results[i];
//       createMarker(results[i]);
//     }
//   }
// };

// const getNearPlaces = (location,distance,map) => {
//   const loc = {lat: location.lat, lng: location.lng};

//   const request = {
//     location: loc,
//     radius: distance,
//     type: ['restaurant']
//   };

//   service = new google.maps.places.PlacesService(map);
//   service.nearbySearch(request, callback);
// };
const initMap = () => {

const mapElement = document.getElementById('map');
if (mapElement) {
  const map = new GMaps({ el: '#map', lat: 48.864716, lng: 2.349014 });
  if (mapElement.dataset.markers !== "") {
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(8);
    } else if (markers.length === 1) {
      map.setCenter(48.864716, 2.349014);
      map.setZoom(8);
    } else if (markers.length == undefined) {
      map.addMarker(markers);
      map.setCenter(markers.lat, markers.lng);
      map.setZoom(14);
      getNearPlaces(markers, 500, map);
    } else {
      map.fitLatLngBounds(markers);
    }
  }
}
}

initMap();


window.initMap = initMap;
