import 'nouislider';

const initSlider = () => {
  var slider = document.getElementById('slider-handles-price');
  if (slider) {
    noUiSlider.create(slider, {
        start: [0, 15000000],
        connect: true,
        range: {
            'min': 0,
            'max': 15000000
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
  };
}


const checkBtnStatus = () => {
  var optionsArray = document.querySelectorAll(".option-choice")
  var count = 0
  optionsArray.forEach( (option) => {
    if (option.className == "option-choice active") {
      count = count + 1
    };
  });

  if (count > 0) {
    return true
  } else {
    return false
  };
};

const applyBtn = (btnId, parentBtnId, submitBtn) => {
  let parentBtn = document.getElementById(parentBtnId)
  let btn = document.getElementById(btnId)
  if (btn) {
    btn.addEventListener("click",(event) => {
      if (checkBtnStatus()){
        submitBtn.click();
        parentBtn.className += " btn-filter-active";
      } else {
        parentBtn.classList.remove("btn-filter-active");;
      };
    });
  };
};

const resetFilters = (filter) => {
  if (filter == "category" || filter == "all") {
    var optionsArray = document.querySelectorAll(".option-choice")
    optionsArray.forEach((option) => {
      option.classList.remove("active")
    });
  }
};

const resetBtn = (btnId, parentBtnId, submitBtn) => {
  let parentBtn = document.getElementById(parentBtnId)
  let btn = document.getElementById(btnId)
  if (btn) {
    btn.addEventListener("click",(event) => {
      resetFilters("category");
      parentBtn.classList.remove("btn-filter-active");;
      submitBtn.click();
    });
  };
};

const toggleCategoryButtons = () => {
  $(document).ready(function(){
  $(".option-choice").click(function(){
    $(this).toggleClass("active");
  });
  });
};

const displayModal = (button, modal, apply, reset) => {
  var btn = document.getElementById(button);
  btn.addEventListener('click',(event) => {
    event.preventDefault();
  });

  var modal = document.getElementById(modal);
  btn.onclick = function() {
    modal.style.display = "block";
  };

  var applyBtn = document.getElementById(apply);
  applyBtn.onclick = function() {
    modal.style.display = "none";
  };
  var resetBtn = document.getElementById(reset);
  resetBtn.onclick = function() {
    modal.style.display = "none";
  };

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
      applyBtn.click();
    }
  }
};



const initSearch = () => {

  const searchForm = document.querySelector(".search_form");
  const submitBtn = document.querySelector(".apply-search-form");

  applyBtn("apply-options-category","btn-asset-category", submitBtn);
  resetBtn("reset-options-category","btn-asset-category", submitBtn);
  initSlider();
  toggleCategoryButtons();


  displayModal("btn-asset-category", "modal-category","apply-options-category","reset-options-category");
  // displayModal("btn-asset-price", "filter-asset-price","apply-options-price");

  if (searchForm) {
    searchForm.addEventListener('change', (event) => {
      // submitBtn.click();
    })
  };


}


export { initSearch }
