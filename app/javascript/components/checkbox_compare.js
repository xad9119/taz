const cards = document.querySelectorAll(".tr-card.checkbox_equiped");

const urlParams = new URLSearchParams(window.location.search);
let query = urlParams.get('query');

console.log(urlParams)

cards.forEach((cb) => {
  cb.querySelector(".checkbox_c").addEventListener("click", (event) => {
    const id = event.currentTarget.dataset.id;
    if(query.includes(id)) {
      query_arr = query.split(' ');
      query_arr.splice(query_arr.indexOf(id),1);
      query = query_arr.join(' ')
    } else {
      query = `${query} ${event.currentTarget.dataset.id}`;
    }
    window.location = `${window.location.href.split('query=')[0]}query=${query}`
  });
});

