import "bootstrap";
import { setupTabEventListeners } from "../components/dashboard_nav";
setupTabEventListeners()
import { setupButtonEventListeners } from "../components/add_button";
setupButtonEventListeners()

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';

initMapbox();


