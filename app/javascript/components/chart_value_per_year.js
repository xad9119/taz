import Chart from 'chart.js';


const chart_value_per_year = (years, values) => {
  var ctx = document.getElementById("value_per_year").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: years,
          datasets: [{
              label: '# of Votes',
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

export { chart_value_per_year };
