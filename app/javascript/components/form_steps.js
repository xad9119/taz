

const initSteps = () => {
  const tabs = document.getElementById('form-tab-1')

  if (tabs) {

    const tabs = document.querySelector('.nav-tabs a')
    tabs.addEventListener('click', (event) => {
      event.preventDefault();
    });
    $(document).ready(function(){
        $(".nav-tabs a").click(function(){
            $(this).tab('show');
        });
        $('.nav-tabs a').on('shown.bs.tab', function(event){
            var x = $(event.target).text();
            var y = $(event.relatedTarget).text();
            $(".act span").text(x);
            $(".prev span").text(y);
        });
    });
  }
}

export { initSteps }
