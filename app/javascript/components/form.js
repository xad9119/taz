const nextBtn = document.getElementById("nextBtn")
if (nextBtn) {
  var currentTab = 0; // Current tab is set to be the first tab (0)
  showTab(currentTab); // Display the current tab
}
function showTab(n) {
  // This function will display the specified tab of the form ...
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  // ... and fix the Previous/Next buttons:
  if (n == 0) {
    document.getElementById("prevBtn").setAttribute("disabled", "");
  } else {
    document.getElementById("prevBtn").disabled=false;
  }
  if (n == (x.length - 1)) {
    document.getElementById("nextBtn").setAttribute("disabled", "");
  } else {
    document.getElementById("nextBtn").disabled=false;
  }
  // ... and run a function that displays the correct step indicator:
  fixStepIndicator(n)
}

function nextPrev(n) {
  // This function will figure out which tab to display
  var x = document.getElementsByClassName("tab");
  if (n == 1 && false) return false;
  x[currentTab].style.display = "none";
  currentTab = currentTab + n;
  if (currentTab >= x.length) {
    currentTab = x.length -1
  } else if (currentTab < 0 ) {
    currentTab = 0
  }
  showTab(currentTab);
}

function fixStepIndicator(n) {
  // This function removes the "active" class of all steps...
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    if (i <= n) {
      x[i].className = x[i].className.replace(" active", "");
      x[i].className += " active";
    } else {
      x[i].className = x[i].className.replace(" active", "");
    }
  }
}

const displayField = () => {
  const displayButton = document.querySelector('#search_break_dates_1');
  const dates = document.querySelector(".break-dates");
  if (displayButton.checked) {
    dates.removeAttribute("hidden", "");
  } else {
    dates.setAttribute("hidden", "");
  };
};


const checkEvents = () => {
  const displayButton = document.querySelector('#search_break_dates_1');
  const hideButton = document.querySelector('#search_break_dates_0');
  if (displayButton) {
   displayButton.addEventListener('click', event => { displayField() });
  } else if (hideButton) {
   hideButton.addEventListener('click', event => {displayField()});
  }
};

const toggleCategoryButtons = () => {
  $(document).ready(function(){
  $(".category-choice").click(function(){
    $(this).toggleClass("active");
  });
  });
};


const formatNumericInputs = () => {
  const numericInputs = document.querySelectorAll(".form-input-numeric")

  if (numericInputs) {
    numericInputs.forEach ((input) => {
      input.addEventListener('change',(event) => {
        let typedNumber = parseInt(event.currentTarget.value.replace(',',''),10);
        event.currentTarget.value = typedNumber.toLocaleString();
      })
    })
  }
};

const checkKey = () => {
  window.addEventListener('keydown', function (e) {
      console.log(e.keyCode);
      if (e.keyCode === 39) {
          nextPrev(1);
      } else if (e.keyCode === 37) {
          nextPrev(-1);
      }
  }, false);
};


const prevNextButtons = () => {
  const nextBtn = document.getElementById("nextBtn")
  if (nextBtn) {
    document.onkeyup = checkKey();
    nextBtn.addEventListener('click', (event) => {
      nextPrev(1);
    });
  };
  const prevBtn = document.getElementById("prevBtn")
  if (prevBtn) {
    prevBtn.addEventListener('click', (event) => {
      nextPrev(-1);
    });
  };
};

const initFormStyle = () => {

  checkEvents();

  toggleCategoryButtons();

  formatNumericInputs();

  prevNextButtons();

}

export { initFormStyle };








