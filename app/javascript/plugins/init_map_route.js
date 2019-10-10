import mapboxgl from 'mapbox-gl';

// build map
// render map
// get markers
// build url for each marker / build array of arry with points
// posts urls
// get response for each layer
// add layer for each response
// add markers
// var merged = [].concat.apply([], array)


// builds the url with a start and end points, fetches data from the mapbox gl api
// extract coordinates for the route between start and end
// manipluates 3d array to 2d
const getMarkers = (map, start, end) => {
  const url = 'https://api.mapbox.com/directions/v5/mapbox/driving/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  let coords = []
  fetch(url)
  .then(response => response.json())
  .then((data) => {
    coords.push(data.routes[0].geometry.coordinates)
    coords = coords.flat()
    addLayer(map, coords);
  });
}

// build the map and initialize the route
const mapBuilder = () => {
  const routeMap = document.getElementById('map-route');
  const markers = JSON.parse(routeMap.dataset.markers);
  mapboxgl.accessToken = routeMap.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: routeMap,
    style: 'mapbox://styles/mapbox/streets-v10',
    center: [markers[0].lng, markers[0].lat], // starting position
    zoom: 12
  });
  const geolocations = markers.map(x => [x.lng, x.lat]);

  for (let i = 0; i < geolocations.length - 1; i++) {
    getMarkers(map, geolocations[i], geolocations[i+1])
  }

  //after the DOM is loaded, resize the map when the tab-button-route is clicked
  document.addEventListener("DOMContentLoaded", function(event) {
    document.querySelector('.tab-button-route').addEventListener('click', () => {
      map.resize();
    });
  });
}


// adds a line (layer) to the map with the id = the first points from the geolocation (arbitrary to have an "unik" id)
//
const addLayer = (map, geolocations) => {
  map.addLayer({
    "id": "" + geolocations[0][0],
    "type": "line",
    "source": {
      "type": "geojson",
      "data": {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "LineString",
          "coordinates": geolocations
        }
      }
    },
    "layout": {
      "line-join": "round",
      "line-cap": "round"
    },
    "paint": {
      "line-color": "#226CD3",
      "line-width": 5
    }
  });
}

export { mapBuilder };
