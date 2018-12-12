// app/javascript/packs/map.js
import GMaps from 'gmaps/gmaps.js';



var myStyle = [
    {
        "featureType": "administrative",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "-100"
            }
        ]
    },
    {
        "featureType": "administrative.province",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -100
            },
            {
                "lightness": 65
            },
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -100
            },
            {
                "lightness": "50"
            },
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "-100"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "all",
        "stylers": [
            {
                "lightness": "30"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "all",
        "stylers": [
            {
                "lightness": "40"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -100
            },
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "hue": "#ffff00"
            },
            {
                "lightness": -25
            },
            {
                "saturation": -97
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels",
        "stylers": [
            {
                "lightness": -25
            },
            {
                "saturation": -100
            }
        ]
    }
]





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
  var styledMapType = new google.maps.StyledMapType(myStyle)
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
      map.addStyle({
        styles: myStyle,
        mapTypeId: 'map_style'
      });
      map.setStyle('map_style');

    }
  }
}


var mapElement = document.getElementById('map');

if (mapElement) {
  initMap();
  window.initMap = initMap;
}
