(function() {
  $(document).ready(function() {
    $("a#hotels_js").click(function(event) {
      event.preventDefault();
      event.stopPropagation();
      return $.ajax({
        url: "tehachapi/hotels",
        type: 'GET',
        success: function(data) {
          return $('.results').html(data);
        }
      });
    });
    $("a#restaurants_js").click(function(event) {
      event.preventDefault();
      event.stopPropagation();
      return $.ajax({
        url: "tehachapi/restaurants",
        type: 'GET',
        success: function(data) {
          return $('.results').html(data);
        }
      });
    });
  });

  return;

}).call(this);
