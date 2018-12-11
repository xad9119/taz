function initSelect() {
  const init = document.getElementById("option");
  if (init) {
    init.addEventListener('change', (event) => {
      const formulaire = event.currentTarget.closest("form");
      formulaire.submit()
    })}
  }

export {initSelect}
