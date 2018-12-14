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


const checkFilterStatus = (filter) => {
  if (filter == "Category") {
    var optionsArray = document.querySelectorAll(".option-choice")
    var count = 0
    var activeOptions = []
    optionsArray.forEach( (option) => {
      if (option.className == "option-choice active") {
        activeOptions.push(option);
      };
    });
    return [activeOptions.length > 0, activeOptions]
  } else {
    return [false, []]
  }

};


const applyBtn = (btnType, btnId, parentBtnId, submitBtn) => {
  let parentBtn = document.getElementById(parentBtnId)
  let btn = document.getElementById(btnId)
  if (btn) {
    btn.addEventListener("click",(event) => {
      var filterStatus = checkFilterStatus(btnType);
      if (filterStatus[0]) {
        parentBtn.className += " btn-filter-active";
        parentBtn.innerHTML = filterStatus[1][0].innerText;
        submitBtn.click();
      } else {
        parentBtn.classList.remove("btn-filter-active");;
        parentBtn.innerHTML = btnType;
      };
    });
  };
};

const resetFilters = (filter) => {
  if (filter == "Category" || filter == "all") {
    var optionsArray = document.querySelectorAll(".option-choice")
    optionsArray.forEach((option) => {
      option.classList.remove("active")
    });
  }
};

const resetBtn = (btnType, btnId, parentBtnId, submitBtn) => {
  let parentBtn = document.getElementById(parentBtnId)
  let btn = document.getElementById(btnId)
  if (btn) {
    btn.addEventListener("click",(event) => {
      resetFilters(btnType);
      parentBtn.classList.remove("btn-filter-active");;
      parentBtn.innerHTML = btnType;
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

const displayModal = (btnType, button, modal, apply, reset) => {
  var btn = document.getElementById(button);
  btn.addEventListener('click',(event) => {
    event.preventDefault();
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
      applyBtn.click();
    }
  }
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

  const submitBtn = document.querySelector(".apply-search-form");
  const initSearchBarBtn = (cat) => {
    const category =   cat.charAt(0).toUpperCase() + cat.substr(1).toLowerCase()
    applyBtn(category,`apply-options-${cat}`,`btn-asset-${cat}`, submitBtn);
    resetBtn(category,`reset-options-${cat}`,`btn-asset-${cat}`, submitBtn);
    displayModal(category,`btn-asset-${cat}`, `modal-${cat}`,`apply-options-${cat}`,`reset-options-${cat}`);

  }
  const searchBtns = ['category','price']

  searchBtns.forEach ((btn) => {
    initSearchBarBtn(btn);
  });

  initSlider();
  toggleCategoryButtons();

  const searchAddress = document.getElementById("search_address");
  if (searchAddress) {
    searchAddress.addEventListener('change', (event) => {
      submitBtn.click();
    })
  };


}


export { initSearch }
