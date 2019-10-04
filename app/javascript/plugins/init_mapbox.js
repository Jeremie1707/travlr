import mapboxgl from 'mapbox-gl';

const MAPS = [];

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: mapElement,
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '20px';
    element.style.height = '28px';
    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 2 });
};

function flyToLocation(currentLocation) {
  map.flyTo({
    center: currentLocation.geometry.coordinates,
    zoom: 15
  });
}

const initMapbox = () => {
  console.log('initMapbox()');
  const mapElements = document.querySelectorAll('.mapbox-map');
  mapElements.forEach(mapElement => {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    map.doubleClickZoom.enable();
    MAPS.push(map);
  });
};

// Event wiring for tab click: re-render map
document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('.tab-button-map').addEventListener('click', () => {
    MAPS.forEach(map => map.resize());
  });
});

export { initMapbox };
