console.log('1')
function initSelect() {
  console.log('2')
  const init = document.getElementById("option");
  if (init) {
    init.addEventListener('change', (event) => {
      console.log('3')
      const formulaire = event.currentTarget.closest("form");
      formulaire.submit()
    })}
  }

export {initSelect}
