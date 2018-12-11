
import "bootstrap";
import "../plugins/flatpickr";
import "jquery";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initFormStyle } from '../components/form';
import { autocomplete } from '../components/autocomplete';
import { initSteps } from '../components/form_steps';
import { initSelect } from '../components/dashboard_select';
import { xxx } from '../components/checkbox_compare';
// import Chart from 'chart.js';



if (document.querySelector("#asset_address")){
  autocomplete();
}

if (document.querySelector("#option")){
  initSelect();
}










