$(document).ready(function(){
  $('.create_booking').click(function (event) 
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
        $(selected_element).replaceWith("<span>Reservado para "+data.user.name+"</span>");
      },
      error: function() {
      }
    });
  }); 
  $('.cancel_booking').click(function (event) 
  { 
    var selected_element = event.target
    event.preventDefault(); 
    $.ajax({
      url: selected_element.href,
      type: 'PUT',
      success: function(data) {
        console.log("success");
        $(selected_element).replaceWith("<span>Disponível</span>");
      },
      error: function() {
        console.log("fail");
      }
    });
  });
});

