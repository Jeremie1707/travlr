import mapboxgl from 'mapbox-gl';

const buildRouteMap = () =>{
  let point_1 = [59.2087144, 10.3316391];
  let point_2 = [68.1560984, 14.2063777];
  console.log("TEST MAP ROUTES");

  const routeMap = document.getElementById('map-route')
  const markers = JSON.parse(routeMap.dataset.markers)
  mapboxgl.accessToken = routeMap.dataset.mapboxApiKey;
  var map = new mapboxgl.Map({
    container: routeMap,
    style: 'mapbox://styles/mapbox/streets-v10',
    center: [markers[0].lng, markers[0].lat], // starting position
    zoom: 12
  });

  var canvas = map.getCanvasContainer();

  var start = [markers[0].lng, markers[0].lat];


  const geolocations = markers.map(x => [x.lng,',', x.lat, ';']);
  const string_array = geolocations.map(x => x.join(''))
  const string = string_array.join('')
  const markers_string = string.substring(0, string.length -1)
  const url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + markers_string + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  console.log(url)



  // magnus sitt forsøk på å bygge url
  console.log(markers)
  const getTrip = () =>{
    // var url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;

    const geolocations = markers.map(x => [x.lng,',', x.lat, ';']);
    const string_array = geolocations.map(x => x.join(''))
    const string = string_array.join('')
    const markers_string = string.substring(0, string.length -1)
    const url = 'https://api.mapbox.com/directions/v5/mapbox/driving/' + markers_string + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  console.log(url)
    var req = new XMLHttpRequest();
    req.responseType = 'json';
    req.open('GET', url, true);
    req.onload = function() {
      var data = req.response.routes[0];
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
      // }
      // map.getSource('route').setData(geojson);
      map.addLayer({
          id: 'route',
          type: 'line',
          source: {
            type: 'geojson',
            data: {
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'LineString',
                coordinates: geojson
              }
            }
          },
          layout: {
            'line-join': 'round',
            'line-cap': 'round'
          },
          paint: {
            'line-color': '#3887be',
            'line-width': 5,
            'line-opacity': 0.75
          }
        });
    };
    req.send();
  }
  getTrip();
  function getRoute(end) {
    var start = [markers[0].lng, markers[0].lat];
    var url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
    var req = new XMLHttpRequest();
    req.responseType = 'json';
    req.open('GET', url, true);
    req.onload = function() {
      var data = req.response.routes[0];
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
      if (map.getSource('route')) {
        map.getSource('route').setData(geojson);
      } else { // otherwise, make a new request
        map.addLayer({
          id: 'route',
          type: 'line',
          source: {
            type: 'geojson',
            data: {
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'LineString',
                coordinates: geojson
              }
            }
          },
          layout: {
            'line-join': 'round',
            'line-cap': 'round'
          },
          paint: {
            'line-color': '#3887be',
            'line-width': 5,
            'line-opacity': 0.75
          }
        });
      }
    };
    req.send();

  }
  //getRoute(start);

  map.on('load', function() {
    // make an initial directions request that
    // starts and ends at the same location
    //var end = [-100.662323, 45.523751];
    getRoute(start);
    getRoute([markers[1].lng, markers[1].lat]);

    // Add starting point to the map
    map.addLayer({
      id: 'point',
      type: 'circle',
      source: {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: [{
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'Point',
              coordinates: start
            }
          }
          ]
        }
      },
      paint: {
        'circle-radius': 10,
        'circle-color': '#3887be'
      }
    });
  });

  // this is where the code from the next step will go
  // markers.forEach(mark => {

  // })

  map.on('click', function(e) {
    var coordsObj = e.lngLat;
    canvas.style.cursor = '';
    var coords = Object.keys(coordsObj).map(function(key) {
      return coordsObj[key];
    });
    var end = {
      type: 'FeatureCollection',
      features: [{
        type: 'Feature',
        properties: {},
        geometry: {
          type: 'Point',
          coordinates: coords
        }
      }]
    };
    if (map.getLayer('end')) {
      map.getSource('end').setData(end);
    } else {
      map.addLayer({
        id: 'end',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: coords
              }
            }]
          }
        },
        paint: {
          'circle-radius': 2,
          'circle-color': '#f30'
        }
      });
    }
  });

  // resize map when tab is clicked
  document.addEventListener("DOMContentLoaded", function(event) {
    document.querySelector('.tab-button-route').addEventListener('click', () => {
      map.resize();
    });
  });
};

export { buildRouteMap };
