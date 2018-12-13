// if (formInput) {
//   formInput.addEventListener('change', (event) => {
//     document.querySelector(".simple_form.search").submit();
//     // this.form.submit();
//   });
// };

const initSearch = () => {


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
