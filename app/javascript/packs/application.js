import "bootstrap";
import "../plugins/flatpickr";
import "jquery";
import { checkEvents } from '../components/form';
import { autocomplete } from '../components/autocomplete';
autocomplete();
import { initSteps } from '../components/form_steps';
initSteps();

import 'mapbox-gl/dist/mapbox-gl.css';

import { initSelect } from '../components/dashboard_select';
initSelect();


import { xxx } from '../components/checkbox_compare';

$(document).ready(function(){
  $(".category-choice").click(function(){
    $(this).toggleClass("active");
  });
});




const numericInputs = document.querySelectorAll(".form-input-numeric")

if (numericInputs) {
  numericInputs.forEach ((input) => {
    input.addEventListener('change',(event) => {
      let typedNumber = parseInt(event.currentTarget.value.replace(',',''),10);
      event.currentTarget.value = typedNumber.toLocaleString();
    })
  })
}
