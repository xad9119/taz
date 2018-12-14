function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var assetAddress = document.getElementById('asset_address');

    if (assetAddress) {
      var autocomplete = new google.maps.places.Autocomplete(assetAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(assetAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}


export { autocomplete };
