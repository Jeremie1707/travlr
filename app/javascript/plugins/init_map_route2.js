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

const getMarkers = (start, end) => {
  const url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  // var req = new XMLHttpRequest();
  // req.responseType = 'json';
  // req.open('GET', url);
  // req.onload = function() {
  //   var data = req.response.routes[0];
  //   const route = data.geometry.coordinates;
  //   console.log(route)
  //   console.log(coords)
  // };
  // req.send();
  let coords = []
  fetch(url)
  .then(response => response.json())
  .then((data) => {
    coords.push(data.routes[0].geometry.coordinates)
  });
  // console.log(coords)
  return coords
}


const mapBuilder = () => {
  const routeMap = document.getElementById('map-route')
  const markers = JSON.parse(routeMap.dataset.markers)
  mapboxgl.accessToken = routeMap.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: routeMap,
    style: 'mapbox://styles/mapbox/streets-v10',
    center: [markers[0].lng, markers[0].lat], // starting position
    // center: [-122.486052, 37.830348],
    zoom: 12
  });
  const geolocations = markers.map(x => [x.lng, x.lat]);
  // console.log(geolocations)
  const temp1 = getMarkers(geolocations[0], geolocations[1])
  console.log(temp1)
  // const temp2 = temp1[0]
  // console.log(temp2)
  // console.log(geolocations)
  // console.log(coordinates)

  const array = [[1,2,3]]
  console.log(array)

  map.on('load', function () {
  map.addLayer({
    "id": "route",
    "type": "line",
    "source": {
      "type": "geojson",
      "data": {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "LineString",
            "coordinates": geolocations
            // [
            //   [-122.48369693756104, 37.83381888486939],
            //   [-122.48348236083984, 37.83317489144141],
            //   [-122.48339653015138, 37.83270036637107],
            //   [-122.48356819152832, 37.832056363179625],
            //   [-122.48404026031496, 37.83114119107971],
            //   [-122.48404026031496, 37.83049717427869],
            //   [-122.48348236083984, 37.829920943955045],
            //   [-122.48356819152832, 37.82954808664175],
            //   [-122.48507022857666, 37.82944639795659],
            //   [-122.48610019683838, 37.82880236636284],
            //   [-122.48695850372314, 37.82931081282506],
            //   [-122.48700141906738, 37.83080223556934],
            //   [-122.48751640319824, 37.83168351665737],
            //   [-122.48803138732912, 37.832158048267786],
            //   [-122.48888969421387, 37.83297152392784],
            //   [-122.48987674713133, 37.83263257682617],
            //   [-122.49043464660643, 37.832937629287755],
            //   [-122.49125003814696, 37.832429207817725],
            //   [-122.49163627624512, 37.832564787218985],
            //   [-122.49223709106445, 37.83337825839438],
            //   [-122.49378204345702, 37.83368330777276]
            // ]
           }
         }
       },
      "layout": {
      "line-join": "round",
      "line-cap": "round"
      },
    "paint": {
      "line-color": "#888",
      "line-width": 8
      }
    });
  });


document.addEventListener("DOMContentLoaded", function(event) {
    document.querySelector('.tab-button-route').addEventListener('click', () => {
      map.resize();
    });
  });
}





export { mapBuilder };
