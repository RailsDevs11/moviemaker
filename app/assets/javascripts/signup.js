$(document).ready(function(){
  
   $('#image_image').live("change",function(){
     if (this.files && this.files[0]) {

        var reader = new FileReader();
        reader.onload = function (e) {
          $('#blah').attr('src', e.target.result);
          $('.uploadedImageBox img').css({'width' : '136px' , 'height' : '200px'});
        }
        reader.readAsDataURL(this.files[0]);
      }
    });

    $('.creative').live("click",function(){
      $(this).closest("form").find('#user_account_type_id').val(1);
    });
    
    $('.discover').live("click",function(){
      $(this).closest("form").find('#user_account_type_id').val(2);
    });
  
    $('.step').live('click', function() {
      var div_id = $(this).attr('div-id');
      $('.signupContent').slideUp();
      $('.rootSignupContent').slideUp();
      $('#step_'+div_id).slideDown();
      $(this).hasClass('joinButton') ? $('.bigSologan').hide() && $('.smallSologan').show() && $('.bottomSearchWrap').hide() : ''
      $(this).hasClass('signup1') ? $('.bigSologan').show() && $('.bottomSearchWrap').show() && $('.smallSologan').hide() : ''
    });

    $('.disable_submit').keypress(function (e) {
      if (e.which == 13) {
        e.preventDefault();
      }
    });
   
    $('.skip_step3').bind('click',function(){
      $('#image_image').val("");
    });
    
    $('.skip_step4').bind('click',function(){
      $('.tag_flag').val("skip_tag");
    });

});
