$(document).ready(function(){

    $('.savelink').bind('click',function(){
      var input_class = this.id.replace('save_btn_','.edit_credit_');
      var input_list = $(input_class);
      for(i=0; i < input_list.length;i++){
        if(input_list[i].value){
          $('#'+$('#' + input_list[i].id).attr('newid')).text(input_list[i].value);
        }else{
          $('#'+$('#' + input_list[i].id).attr('newid')).text(input_list[i].options[input_list[i].selectedIndex]);
        }
      }
    });

    //user public page
    $('.readMore').bind('click',function(){
      $('#showMore').show();
      $('#showLess').hide();
      $('.readMore').hide();
      $('.readLess').show();
    });

    $('.readLess').bind('click',function(){
      $('#showMore').hide();
      $('#showLess').show();
      $('.readMore').show();
      $('.readLess').hide();
    });
});
