import { initMapbox } from '../plugins/init_mapbox';

var total = {
  value: 0
};

function plural(time, exp) {
  if (time === 1) {
    return exp;
  } else {
    return exp + 's';
  }
}

function duration(time) {
  const q = Math.floor(time / 60);
  const r = time % 60;

  if (r === 0) {
    return `${q} ${plural(q, 'hour')}`;
  } else if (q === 0) {
    return `${r} ${plural(r, 'min')}`;
  } else {
    return `${q} ${plural(q, 'hour')} and ${r} ${plural(r, 'min')}`;
  }
}

var tripDuration = document.getElementById('trip-duration');

mapboxgl.accessToken = 'pk.eyJ1Ijoic3RldmVzcGlkZXJzIiwiYSI6ImNrN2JqZW43MjAyM3YzcWxjb2VkZG9qNmUifQ.iMQH53oEUdtY8nAbUaAl3w';
const mapElement = document.getElementById('map');
let markers = JSON.parse(mapElement.dataset.markers);
var start = [markers[0].lng, markers[0].lat];
var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v10',
  center: start
});
// set the bounds of the map
// var bounds = [[-123.069003, 45.395273], [-122.303707, 45.612333]];
// map.setMaxBounds(bounds);

// initialize the map canvas to interact with later
var canvas = map.getCanvasContainer();

initMapbox();

// an arbitrary start will always be the same
// only the end or destination will change

// this is where the code for the next step will go
// create a function to make a directions request
function getRoute(end) {
  // make a directions request using cycling profile
  // an arbitrary start will always be the same
  // only the end or destination will change
  var start = [markers[0].lng, markers[0].lat];
  var url = 'https://api.mapbox.com/directions/v5/mapbox/walking/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;

  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  var req = new XMLHttpRequest();
  req.open('GET', url, true);
  req.onload = function() {
    var json = JSON.parse(req.response);
    var data = json.routes[0];
    var route = data.geometry.coordinates;
    var geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    // if the route already exists on the map, reset it using setData
    // if (map.getSource('route')) {
    //   map.getSource('route').setData(geojson);
    // } else { // otherwise, make a new request
    //   map.addLayer({
    //     id: 'route',
    //     type: 'line',
    //     source: {
    //       type: 'geojson',
    //       data: {
    //         type: 'Feature',
    //         properties: {},
    //         geometry: {
    //           type: 'LineString',
    //           coordinates: geojson
    //         }
    //       }
    //     },
    //     layout: {
    //       'line-join': 'round',
    //       'line-cap': 'round'
    //     },
    //     paint: {
    //       'line-color': '#3887be',
    //       'line-width': 5,
    //       'line-opacity': 0.75
    //     }
    //   });
    // }
    // add turn instructions here at the end

  };
  req.send();
}

map.on('load', function() {
  // make an initial directions request that
  // starts and ends at the same location
  getRoute(start);

  // Add starting point to the map
  // map.addLayer({
  //   id: 'point',
  //   type: 'circle',
  //   source: {
  //     type: 'geojson',
  //     data: {
  //       type: 'FeatureCollection',
  //       features: [{
  //         type: 'Feature',
  //         properties: {},
  //         geometry: {
  //           type: 'Point',
  //           coordinates: start
  //         }
  //       }
  //       ]
  //     }
  //   },
  //   paint: {
  //     'circle-radius': 10,
  //     'circle-color': '#3887be'
  //   }
  // });

  for (let i = 1; i < markers.length; i++) {

    canvas.style.cursor = '';
    var coords = [markers[i].lng, markers[i].lat];
    var end = {
      type: 'FeatureCollection',
      features: [{
        type: 'Feature',
        properties: {},
        geometry: {
          type: 'Point',
          coordinates: coords
        }
      }
      ]
    };
    // if (map.getLayer('end')) {
    //   map.getSource('end').setData(end);
    // } else {
    //   map.addLayer({
    //     id: 'end',
    //     type: 'circle',
    //     source: {
    //       type: 'geojson',
    //       data: {
    //         type: 'FeatureCollection',
    //         features: [{
    //           type: 'Feature',
    //           properties: {},
    //           geometry: {
    //             type: 'Point',
    //             coordinates: coords
    //           }
    //         }]
    //       }
    //     },
    //     paint: {
    //       'circle-radius': 10,
    //       'circle-color': '#f30'
    //     }
    //   });
    // }
    getRoute(coords);
  }
});
