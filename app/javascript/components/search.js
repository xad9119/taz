import 'nouislider';

const initSearch = () => {

  var searchForm = document.querySelector(".search_form")

  if (searchForm) {
    searchForm.addEventListener('change', (event) => {
      document.querySelector(".test-apply").click();
    })
  };


  var slider = document.getElementById('slider-handles');
  if (slider) {
    noUiSlider.create(slider, {
        start: [0, 10000000],
        connect: true,
        range: {
            'min': 0,
            'max': 10000000
        },
        step: 100000,
    });
    var rangeSliderValueElement = document.getElementById('slider-range-value');
    var rangeSliderMinValue = document.querySelector('.slider-min-value');
    var rangeSliderMaxValue = document.querySelector('.slider-max-value');

    slider.noUiSlider.on('update', function (values, handle) {
      rangeSliderValueElement.value = slider.noUiSlider.get();
      rangeSliderMinValue.innerHTML =  `min: €${parseInt(slider.noUiSlider.get()[0],10).toLocaleString()}`;
      rangeSliderMaxValue.innerHTML =  `max: €${parseInt(slider.noUiSlider.get()[1],10).toLocaleString()}`;
    });
  }


  var filterBtns = document.querySelectorAll(".filters")


    // Get the button that opens the modal
  const displayModal = (button, modal, option) => {
    var btn = document.getElementById(button);
    btn.addEventListener('click',(event) => {
      event.preventDefault();
    });

    var modal = document.getElementById(modal);
    btn.onclick = function() {
      modal.style.display = "block";
    }

    var span = document.getElementById(option);

    span.onclick = function() {
      modal.style.display = "none";
    }
  }

  displayModal("btn-asset-category", "filter-asset-category","apply-options-category")
  displayModal("btn-asset-price", "filter-asset-price","apply-options-price")


  const toggleCategoryButtons = () => {
    $(document).ready(function(){
    $(".option-choice").click(function(){
      $(this).toggleClass("active");
    });
    });
  };
  toggleCategoryButtons();
}


export { initSearch }
