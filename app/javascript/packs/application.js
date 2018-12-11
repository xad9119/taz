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

initFormStyle();
autocomplete();
initSelect();
// initSteps();








