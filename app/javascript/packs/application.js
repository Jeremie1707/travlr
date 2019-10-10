import "bootstrap";
import flatpickr from "flatpickr";
import 'flatpickr/dist/flatpickr.min.css'
import { initFlatpickr } from '../plugins/flatpickr'

import { setupTabEventListeners } from "../components/dashboard_nav";
import { setupButtonEventListeners } from "../components/add_button";

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { mapBuilder } from '../plugins/init_map_route';

setupButtonEventListeners()
setupTabEventListeners()
initFlatpickr();
initMapbox();
mapBuilder();

