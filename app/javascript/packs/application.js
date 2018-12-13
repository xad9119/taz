import "jquery-ui";
import "bootstrap";
import "../plugins/flatpickr";
import "jquery";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initFormStyle } from '../components/form';
import { initSearch } from '../components/search';
import { initDashboard } from '../components/dashboard';
import { autocomplete } from '../components/autocomplete';
import { initSteps } from '../components/form_steps';
import { initSelect } from '../components/dashboard_select';
import { xxx } from '../components/checkbox_compare';

if (document.querySelector("#asset_address")){
  autocomplete();
}
if (document.querySelector("#nextBtn")){
  initFormStyle();
}

if (document.getElementById("btn-asset-category")) {
  initSearch();
}


initDashboard();
