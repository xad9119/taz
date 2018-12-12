import { chart_bubble, chart_q_per_cat, chart_value_per_year, chart_price_per_asset } from '../components/charts';

const initDashboard = () => {

  if (document.getElementById("price_per_asset")) {
   const myId = document.getElementById("price_per_asset");
   const assets = JSON.parse(myId.dataset.assets);
   const prices = JSON.parse(myId.dataset.prices);
   chart_price_per_asset(assets, prices);
  };

  if (document.getElementById("value_per_year")) {
   const myId = document.getElementById("value_per_year");
   const years = JSON.parse(myId.dataset.years);
   const values = JSON.parse(myId.dataset.values);
   chart_value_per_year(years, values);
  };

  if (document.getElementById("q_per_cat")) {
   const myId = document.getElementById("q_per_cat");
   const categories = JSON.parse(myId.dataset.categories);
   const values = JSON.parse(myId.dataset.values);
   chart_q_per_cat(categories, values);
  };

  if (document.getElementById("bubble")) {
   const myId = document.getElementById("bubble");
   console.log(myId.dataset.points);
   const points = JSON.parse(myId.dataset.points);
   chart_bubble(points);
  };
}

export { initDashboard }
