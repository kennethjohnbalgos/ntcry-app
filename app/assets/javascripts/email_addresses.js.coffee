# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#cancel_link').live 'click', ->
		$('#new_email_form_space').fadeOut 'fast', ->
			$('#no_email_space').fadeIn()
			add_activity('Adding email address cancelled')