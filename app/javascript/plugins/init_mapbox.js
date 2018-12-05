import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    const mapMarkers = [];
      markers.forEach((marker) => {
        mapMarkers.push(marker);
      });
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
 const cards = document.querySelectorAll('.card');
  cards.forEach((card, index) => {
    // Put a microphone on each card listenning for a hover event
    card.addEventListener('mouseenter', () => {
      // Here we trigger the display of the corresponding marker infoWindow as it is the default behavior of a click on a  marker
      google.maps.event.trigger(mapMarkers[index], 'click');
    });
  });
};






export { initMapbox };
