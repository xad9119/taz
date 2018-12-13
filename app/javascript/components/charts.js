import Chart from 'chart.js';


const chart_value_per_year = (years, values) => {
  var ctx = document.getElementById("value_per_year").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: years,
          datasets: [{
              label: 'Rentals revenues (k€/y)',
              data: values,
              backgroundColor: 'rgba(75, 192, 192, 0.5)',
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
          legend: {
                      display: false
                  },
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
      type: 'horizontalBar',
      data: {
          labels: assets,
          datasets: [{
              label: 'Rentals revenues (k€/y)',
              data: prices,
              backgroundColor: 'rgba(54, 162, 235, 0.5)',
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
          aspectRatio: 0.8,
          legend: {
                      display: false
                  },
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }],
              xAxes: [{
                  scaleLabel: {
                                            display: true,
                                            labelString: 'k€/y'
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
          data: prices,
          backgroundColor: [
                          'rgba(255, 99, 132, 0.5)',
                          'rgba(54, 162, 235, 0.5)',
                          'rgba(255, 206, 86, 0.5)',
                          'rgba(75, 192, 192, 0.5)',
                          'rgba(153, 102, 255, 0.5)',
                          'rgba(255, 159, 64, 0.5)'
                      ]
      }],
      options: {
        legend: {
                    display: true
                },
      },

      // These labels appear in the legend and in the tooltips when hovering different arcs
      labels: categories
  };
  var myDoughnutChart = new Chart(ctx, {
      type: 'doughnut',
      data: data
  });
};

const chart_bubble = (points) => {
  var ctx = document.getElementById("bubble").getContext('2d');
  var scatterChart = new Chart(ctx, {
      type: 'bubble',
      data: {
          datasets: [{
              label:'',
              data: points,
              backgroundColor:'rgba(255, 99, 132, 0.5)',
          }]
      },
      options: {
          aspectRatio: 1.2,
          legend: {
                      display: false
                  },
          scales: {
              yAxes: [{
                  type: 'linear',
                  position: 'bottom',
                  ticks: {
                          min: 0
                      },
                  scaleLabel: {
                          display: true,
                          labelString: 'rentals revenues (k€/y)'
                        }
              }],
              xAxes: [{
                  type: 'linear',
                  position: 'bottom',
                  ticks: {
                          min: 0,
                          max: 30
                      },
                  scaleLabel: {
                          display: true,
                          labelString: '# months before end of current lease'
                        }
              }]
          }
      }
  });
};

export { chart_bubble, chart_q_per_cat, chart_value_per_year, chart_price_per_asset };
