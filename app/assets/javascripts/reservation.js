$(function() {
  $(document).on( "click", ".create_booking", function(event)
  { 
    var selected_element = event.target
    event.preventDefault(); 
    $.ajax({
      url: selected_element.href,
      headers: {
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
      },
      type: 'POST',
      data: {
        'reservation': { "booked_at": $(this).attr('booked_at') }
      },
      success: function(data) {
        $(selected_element).attr({
          class: "cancel_booking",
          href: "/reservations/"+ data.id
        }).text("Cancelar reserva");
      },
      error: function() {
      }
    });
  }); 
  
  $(document).on( "click", ".cancel_booking", function(event)  
  { 
    var selected_element = event.target
    event.preventDefault(); 
    $.ajax({
      url: selected_element.href,
      type: 'PUT',
      success: function(data) {
        $(selected_element).attr({
          class: "create_booking",
          href: "/reservations/",
          booked_at: data.booked_at
        }).text("Disponível");
      },
      error: function() {
      }
    });
  });
});

