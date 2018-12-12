
import "jquery-ui";
import "bootstrap";
import "../plugins/flatpickr";
import "jquery";
import 'mapbox-gl/dist/mapbox-gl.css';

require('webpack-jquery-ui');
require('webpack-jquery-ui/css');

import { initFormStyle } from '../components/form';
import { autocomplete } from '../components/autocomplete';
import { initSteps } from '../components/form_steps';
import { initSelect } from '../components/dashboard_select';
import { xxx } from '../components/checkbox_compare';
import { chart_price_per_asset } from '../components/chart_price_per_asset';
import { chart_value_per_year } from '../components/chart_value_per_year';


if (document.querySelector("#asset_address")){
  autocomplete();
}
if (document.querySelector("#nextBtn")){
  initFormStyle();
}

if (document.querySelector("#option")){
  initSelect();
}

if (document.getElementById("price_per_asset")) {
 const myId = document.getElementById("price_per_asset");
 const assets = JSON.parse(myId.dataset.assets);
 const prices = JSON.parse(myId.dataset.prices);
 chart_price_per_asset(assets, prices);
};

if (document.getElementById("value_per_year")) {
 const myId = document.getElementById("value_per_year");
 const years = JSON.parse(myId.dataset.years);
 const values = JSON.parse(myId.dataset.values);
 chart_value_per_year(years, values);
};

