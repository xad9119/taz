// app/javascript/packs/map.js
import GMaps from 'gmaps/gmaps.js';

const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 48.864716, lng: 2.349014 });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(4);
  } else if (markers.length === 1) {
    map.setCenter(markers[48.864716].lat, markers[2.349014].lng);
    map.setZoom(4);
  } else {
    map.fitLatLngBounds(markers);
  }
}
