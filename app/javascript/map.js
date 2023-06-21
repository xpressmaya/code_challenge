document.addEventListener('DOMContentLoaded', function() {
  polygonString = "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))";
  var coordinatesString = polygonString.slice(9, -2);
  var coordinatePairs = coordinatesString.split(',');
  var polygonCoordinates = [];
  coordinatePairs.forEach(function(pair) {
    var latLng = pair.trim().split(' ');
    polygonCoordinates.push([parseFloat(latLng[1]), parseFloat(latLng[0])]);
  });
  var map = L.map('map').setView([32.06537765335268, -81.05322183341679], 12);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors'
  }).addTo(map);
  var polygon = L.polygon(polygonCoordinates, { color: 'blue' }).addTo(map);
  map.fitBounds(polygon.getBounds());
});
