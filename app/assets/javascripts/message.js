// $(".msgbox").keydown(function(e) {
//     if (e.keyCode == 13) 
//     {
//       alert('sdfsd');
//     }
// });

function send_message(name) 
{
  alert('sdfsd');
	var name = $(name);

  //name.parent().hide();
  //$('.msgwait').show();
  
  var msgval = $('.msgbox');      

  if(msgval.val() != "")
  {
    var form = $('#send_message_form')[0]; 
    var formData = new FormData(form);

    $.ajax({
        type: 'post',
        url: 'message',
        contentType: false,
        processData: false,  
        data: formData,          
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function(data) {  

          msgval.val('');      
          //$('.msgwait').hide();
          //name.parent().show();

          if(data.status == false)
          {
            var er = data.errors;
            $('#errors').show();
            $.each(er ,function( index,msg ) 
            {       
            $('#errors ul').append('<li>' + msg + '</li>');
            });           
          }
          
          // else
          // {
          //  //  $("#article_add_form")[0].reset();

          //  //  $('#suc_msg').show();
          //  //  $('#suc_msg').html('Article Added Successfully! Page will be reload in 3 second.');
          //  //  setTimeout(function(){ location.href = data.redirect_to; }, 2000);
          // }
        }
    });
  }


}