
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
// import Chart from 'chart.js';



// const formInput = document.getElementById("search_address");



// if (formInput) {
//   formInput.addEventListener('change', (event) => {
//     document.querySelector(".simple_form.search").submit();
//     // this.form.submit();
//   });
// };



  // if (document.querySelector("#asset_address")){
  //   autocomplete();
  // }

  // if (document.querySelector("#option")){
  //   initSelect();
  // }


  // var filterBtns = document.querySelectorAll(".filter-btn")
  // filterBtns.forEach((btn) =>{
  //   btn.addEventListener('click',(event) => {
  //     event.preventDefault();
  //   });
  // });
  // // Get the modal
  // var modal = document.getElementById('filter-asset-category');

  // // Get the button that opens the modal
  // var btn = document.getElementById("btn-asset-category");

  // // Get the <span> element that closes the modal
  // var span = document.getElementsByClassName("close")[0];

  // // When the user clicks on the button, open the modal
  // btn.onclick = function() {
  //   modal.style.display = "block";
  // }

  // // When the user clicks on <span> (x), close the modal
  // span.onclick = function() {
  //   modal.style.display = "none";
  // }

  // // When the user clicks anywhere outside of the modal, close it
  // window.onclick = function(event) {
  //   console.log(event.target == modal);
  //   console.log(event.target);
  //   if (event.target == modal) {
  //     modal.style.display = "none";
  //   }
  // }


  // const toggleCategoryButtons = () => {
  //   $(document).ready(function(){
  //   $(".category-choice").click(function(){
  //     $(this).toggleClass("active");
  //   });
  //   });
  // };
  // toggleCategoryButtons();








