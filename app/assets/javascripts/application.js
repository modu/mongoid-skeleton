// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(function() {
	
	
	$('#itembuttonadd').click(function() {

	    var num     = $('.itemclone').length; // how many "duplicatable" input fields we currently have
	    var newNum  = new Number(num + 1);      // the numeric ID of the new input field being added
		var newElem = $('#item' + num).clone().attr('id', 'item' + newNum);
		newElem.children('#question'+num).attr('id', 'question' +  newNum ).attr('name', 'question' +  newNum ).attr('value', '');
	    newElem.children('#answer'+num).attr('id', 'answer' +  newNum ).attr('name', 'answer'+ newNum ).attr('value', '');
		$('#item' + num).after(newElem);
		if (num >= 1){
		    $("#itembuttondelete").attr("disabled", false );
		}
	});
	$('#itembuttondelete').click(function() {
		    var num = $('.itemclone').length; 
		    $('#item' + num).remove();     
		    $('#itembuttonadd').attr('disabled', false );
		       if (num-1 == 1)
		         $('#itembuttondelete').attr('disabled',true);
	});
	
	
	$('#kcsbuttonadd').click(function() {

	    var num     = $('.kcclone').length; // how many "duplicatable" input fields we currently have
	    var newNum  = new Number(num + 1);      // the numeric ID of the new input field being added
		var newElem = $('#kc' + num).clone().attr('id', 'kc' + newNum);
		newElem.children('#kcname'+num).attr('id', 'kcname' +  newNum ).attr('name', 'kcname' +  newNum ).attr('value', '');
        newElem.children('#L'+num).attr('id', 'L' +  newNum ).attr('name', 'L' +  newNum ).attr('value', '');
        newElem.children('#G'+num).attr('id', 'G' +  newNum ).attr('name', 'G' +  newNum ).attr('value', '');
        newElem.children('#T'+num).attr('id', 'T' +  newNum ).attr('name', 'T'+ newNum ).attr('value', '');
        newElem.children('#S'+num).attr('id', 'S' +  newNum ).attr('name', 'S' +  newNum ).attr('value', '');
        newElem.children('#itemnumbers'+num).attr('id', 'itemnumbers' +  newNum ).attr('name', 'itemnumbers'+ newNum ).attr('value', '');

		$('#kc' + num).after(newElem);
		if (num >= 1){
		    $("#kcsbuttondelete").attr("disabled", false );
		}
	});
	$('#kcsbuttondelete').click(function() {
		    var num = $('.kcclone').length; 
		    $('#kc' + num).remove();     
		    $('#kcsbuttonadd').attr('disabled', false );
		       if (num-1 == 1)
		         $('#kcsbuttondelete').attr('disabled', true);
	});
	
	$("#itembuttondelete").attr("disabled", true);
    $('#kcsbuttondelete').attr('disabled', true);
    
	
	
});

