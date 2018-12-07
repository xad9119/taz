import "bootstrap";
import "../plugins/flatpickr";

import { checkEvents } from '../components/form';
import { autocomplete } from '../components/autocomplete';
import { initShowTab, nextPrev } from '../components/form_steps';
import 'mapbox-gl/dist/mapbox-gl.css';
// checkEvents();
// initShowTab ();

autocomplete();

import { xxx } from '../components/checkbox_compare';


btn = document.getElementById('nextBtn')

if (btn) {
  btn.addEventListener('click', openCity(event, 'form-tab-2'))
};
function openCity(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
