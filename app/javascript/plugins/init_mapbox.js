//import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    if (marker) {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
      }
    });
  };

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => {
      if (marker) {
        bounds.extend([ marker.lng, marker.lat ])
      }
    }
  );
  map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 0 });
};

const initMapbox = () => {
  console.log('init')
  const mapIndex = document.getElementById("map");

  if (mapElement) {

    const map = buildMap();

    //map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                          //mapboxgl: mapboxgl }));
    if (mapIndex.dataset.markers.length > 4) {
      let markers = JSON.parse(mapElement.dataset.markers);
      if (!Array.isArray(markers)) {
        markers = [JSON.parse(mapElement.dataset.markers)];
      }
      if (markers) {
        addMarkersToMap(map, markers);
        fitMapToMarkers(map, markers);
      }
    }
  }
};
export { initMapbox };
