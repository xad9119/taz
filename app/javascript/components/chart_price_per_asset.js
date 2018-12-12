import Chart from 'chart.js';


const chart_price_per_asset = (assets, prices) => {
  var ctx = document.getElementById("price_per_asset").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: assets,
          datasets: [{
              label: '# of Votes',
              data: prices,
              // backgroundColor: [
              //     'rgba(255, 99, 132, 0.2)',
              //     'rgba(54, 162, 235, 0.2)',
              //     'rgba(255, 206, 86, 0.2)',
              //     'rgba(255, 159, 64, 0.2)'
              // ],
              // borderColor: [
              //     'rgba(255,99,132,1)',
              //     'rgba(54, 162, 235, 1)',
              //     'rgba(255, 206, 86, 1)',
              //     'rgba(255, 159, 64, 1)'
              // ],
              borderWidth: 1
          }]
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }]
          }
      }
  });
};

export { chart_price_per_asset };
