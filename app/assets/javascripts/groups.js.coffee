# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#group_form_submit').live 'click', ->
		submit = $(this)
		form = submit.parents().find('form#group_form')
		disabled = false
		form.children().find('input').each ->
			$(this).blur()
	
		form.children().find('.error_space').each ->
			if($(this).html() != "")
				disabled = true
			
		if(disabled)
			form.children().find('input[type=submit]').css('opacity',0.7)
			form.children().find('input[type=submit]').attr('disabled',true)
		else
			form.children().find('input[type=submit]').css('opacity',1)
			form.children().find('input[type=submit]').attr('disabled',false)
			show_spinner(submit)
			form.submit()
		false