import "bootstrap";
import "../plugins/flatpickr";
import "jquery";
import { checkEvents } from '../components/form';
import { autocomplete } from '../components/autocomplete';
import { initSteps } from '../components/form_steps';
import 'mapbox-gl/dist/mapbox-gl.css';

initSteps();

autocomplete();

import { xxx } from '../components/checkbox_compare';



// const btn = document.getElementById('nextBtn')

// if (btn) {
//   btn.addEventListener('click', openCity)
// };

// const openCity = (event) => {
//     // Declare all variables
//     var i, tabcontent, tablinks;
//     cityName = 'form-tab-2'

//     // Get all elements with class="tabcontent" and hide them
//     tabcontent = document.getElementsByClassName("tabcontent");
//     for (i = 0; i < tabcontent.length; i++) {
//         tabcontent[i].style.display = "none";
//     }

//     // Get all elements with class="tablinks" and remove the class "active"
//     tablinks = document.getElementsByClassName("tablinks");
//     for (i = 0; i < tablinks.length; i++) {
//         tablinks[i].className = tablinks[i].className.replace(" active", "");
//     }

//     // Show the current tab, and add an "active" class to the button that opened the tab
//     document.getElementById(cityName).style.display = "block";
//     evt.currentTarget.className += " active";
// }


// const moveWagons = (event) => {
//   if (event.key === "a") {
//     moveForward(1);
//   } else if (event.key === "p") {
//     moveForward(2);
//   }
// };
