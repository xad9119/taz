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

if (document.querySelector("#option")){
  initSelect();
}


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



// Look for .hamburger
var hamburger = document.querySelector(".hamburger");
// On click
if (hamburger) {
  hamburger.addEventListener("click", function() {
    // Toggle class "is-active"
    hamburger.classList.toggle("is-active");
    // Do something else, like open/close menu
  });
}
