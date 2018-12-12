import Chart from 'chart.js';


const chart_value_per_year = (years, values) => {
  var ctx = document.getElementById("value_per_year").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: years,
          datasets: [{
              label: 'Asset Under Management (M€)',
              data: values,
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

const chart_price_per_asset = (assets, prices) => {
  var ctx = document.getElementById("price_per_asset").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: assets,
          datasets: [{
              label: 'Asset Under Management (M€)',
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

const chart_q_per_cat = (categories, prices) => {
  var ctx = document.getElementById("q_per_cat").getContext('2d');
  var data = {
      datasets: [{
          data: prices
      }],

      // These labels appear in the legend and in the tooltips when hovering different arcs
      labels: categories
  };
  var myDoughnutChart = new Chart(ctx, {
      type: 'doughnut',
      data: data
  });
};

export { chart_q_per_cat, chart_value_per_year, chart_price_per_asset };
