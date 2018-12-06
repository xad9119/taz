

const displayField = () => {
  console.log("hello")
  const display_button = document.querySelector('#search_break_dates_1');
  const dates = document.querySelector(".break-dates");
  if (display_button.checked) {
    dates.removeAttribute("hidden", "");
  } else {
    dates.setAttribute("hidden", "");
  };
};


const checkEvents = () => {
  const display_button = document.querySelector('#search_break_dates_1');
  const hide_button = document.querySelector('#search_break_dates_0');


  display_button.addEventListener('click', event => {displayField()})
  hide_button.addEventListener('click', event => {displayField()})
};

export {checkEvents};
