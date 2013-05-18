/**
 * application.js by @folkgraphein
 * Copyright 2012 Cinimaker .
 */
$(document).ready(function () {

    $('.locationCity select').chosen();
    $('.styleSelect select').chosen();
    $('.boxCreditType select,.boxYear select').chosen();
	$('.locationSelectBox select').chosen();

    // Sub Navigation for Main menu

    var callOne = $('#call_subNav1');
    var callTwo = $('#call_subNav2');
    var callThree = $('#call_subNav3');
    var subNavOne = $('.subNavOne').addClass('animated fadeInDown').hide();
    var subNavTwo = $('.subNavTwo').addClass('animated fadeInDown').hide();
    var subNavThree = $('.subNavThree').addClass('animated fadeInDown').hide();

    // Sub-Navigation One 

    callOne.on("click", function (e) {
        subNavTwo.hide();
        subNavThree.hide();
        $('.subNavOne').removeClass('fadeOutUp');
        subNavOne.slideToggle();
        e.stopPropagation();
    });
    $(document).click(function (e) {
        $('.subNavOne:visible').addClass('fadeOutUp');
        if (e.srcElement !== subNavOne) subNavOne.fadeOut(1000);
    });

    // Sub-Navigation Two 

    callTwo.on("click", function (e) {
        subNavOne.hide();
        subNavThree.hide();
        $('.subNavTwo').removeClass('fadeOutUp');
        subNavTwo.slideToggle();
        e.stopPropagation();
    });
    $(document).click(function (e) {
        $('.subNavTwo:visible').addClass('fadeOutUp');
        if (e.srcElement !== subNavTwo) subNavTwo.fadeOut(1000);
    });

    // Sub-Navigation Three

    callThree.on("click", function (e) {
        subNavOne.hide();
        subNavTwo.hide();
        $('.subNavThree').removeClass('fadeOutUp');
        subNavThree.slideToggle();
        e.stopPropagation();
    });
    $(document).click(function (e) {
        $('.subNavThree:visible').addClass('fadeOutUp');
        if (e.srcElement !== subNavThree) subNavThree.fadeOut(1000);
        $('.mainNav > li').removeClass("active");
    });

    // main Navigation active class

    $('.mainNav > li').click(function (e) {
        e.preventDefault();
        $('.mainNav > li').toggleClass("active").not(this).removeClass("active");
    });

    // Edit Credit Toggling Effect

    $('.dataWrap:odd').css({
        'background-color': '#e4e3dc'
    });

    $('.dataWrap .openEditCridit').click(function (e) {
        e.preventDefault();
        //$('.dataWrap .openEditCridit').toggleClass("active").not(this).removeClass("active");
        $(this).closest('.dataWrap').children('.adminEditCredit').toggle(300);
    });

    // Page Tab Content 'Needs'

    $('.needConRow li:even').css({
        'background-color': '#ffffff'
    });
    $('.needConRow li:odd').css({
        'background-color': '#e4e3dc'
    });

    // Cini Page Tab Content Needs bottom arrow click event 	

 //   var bottomDiv = '<div id="bottomBorder"><a href="#" id="bottomClick"></a></div>';

 //   $('.needsTabConIn').after(bottomDiv);

 //   $('#bottomClick').live('click', function (e) {
 //       e.preventDefault();
 //       $('.needsTabConIn').css({
 //           'height': 'auto',
 //           'overflow': 'visible'
 //       });
 //       $('#bottomBorder').remove();
 //   });

//    var bottomDiv2 = '<div id="bottomBorder2"><a href="#" id="bottomClick2"></a></div>';

//    $('.updateTabConIn').after(bottomDiv);

//    $('#bottomClick').live('click', function (e) {
 //       e.preventDefault();
//        $('.updateTabConIn').css({
//            'height': 'auto',
//            'overflow': 'visible'
//        });
//        $('#bottomBorder2').remove();
//    });

    // Cini Page Tab Content Crew li hover effect 

    $('.ciniCrew li').on('mouseenter', function (e) {
        $('.roleTooltip', this).show(100);
    });
    $('.ciniCrew li').on('mouseleave', function (e) {
        $('.roleTooltip', this).hide(80);
    });
	
	 // Profile Page CINI tab Content li hover effect 

    $('.cinithumbs li').on('mouseenter', function (e) {
        $('.ciniTooltip', this).show(100);
    });
    $('.cinithumbs li').on('mouseleave', function (e) {
        $('.ciniTooltip', this).hide(80);
    });


    // inbox Page invoking
	
    $('.allMessage li input[type="checkbox"]').change(function () {
        var toggling = $(this).closest('li');
        toggling.toggleClass('selected');
    });
	
	$('.connectionRow li input[type="checkbox"]').change(function () {
        var toggling = $(this).closest('li');
        toggling.toggleClass('selected');
    });
	
	$('.notiRow li input[type="checkbox"]').change(function () {
        var toggling = $(this).closest('li');
        toggling.toggleClass('selected');
    });


    // Cini Page Tab Content Crew li hover effect 

    $('#movie_carousel li').on('mouseenter', function (e) {
        $('.tooltip1', this).show(100);
    });
    $('#movie_carousel li').on('mouseleave', function (e) {
        $('.tooltip1', this).hide(80);
    });



}); // End document Ready function
