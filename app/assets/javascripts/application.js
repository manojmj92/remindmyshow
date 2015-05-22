// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//=require jquery
//=require jquery_ujs
//=require jquery-ui
//=require turbolinks
//=require_tree .


jQuery(function($){
	var email = $('#email'),
		location = $('#location'),
		movie_name = $('#movie_name'),
		movie_box = $('#movie_name_box'),
		location_box = $('#location_box'),
		email_box = $('#email_box'),
		thankyou = $('#thankyou'),
		book_form = $('#book_form')

	function show_email (suggestion) {
		location_box.fadeOut('slow', function() {
			
				email_box.fadeIn('slow', function() {
					
						email.focus();
					
				});
			
		});		
	}
	function show_location (suggestion) {
		movie_box.fadeOut('slow', function() {

				location_box.fadeIn('slow', function() {
					
						location.focus();
					
				});

		});		
	}

	function show_submit (argument) {

		var email_val = email.val();
		var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    	if(re.test(email_val)){
    		email_box.fadeOut('slow', function() {
    			
				thankyou.fadeIn('slow', function() {
				});
			});
    	}else{
    		email.addClass('error_input').focus();
    		email.keypress(function(event) {
    			email.removeClass('error_input')
    		});
    	}
		
	}


	$('#movie_name').autocomplete({
	    serviceUrl: '/search/movie',
	    onSelect: function (suggestion) {
	        show_location(suggestion)
	    }
	});

	$('#location').autocomplete({
	    serviceUrl: '/search/location',
	    onSelect: function (suggestion) {
	        show_email(suggestion)
	    }
	});

	$("#book_form").on("submit", function (e) {
	    
	    	show_submit(e);
	    
	});
	
	$("#book_form").on("keypress", function (e) {
	    if (e.keyCode == 13) {
	    	var email_val = email.val()
	    	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    		
	        if (email_val != null && !re.test(email_val) ) {
	        	return false;
	    	}
	    }
	});
});