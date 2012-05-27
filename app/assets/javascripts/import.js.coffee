# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#import_google').live 'click', ->
		$(this).children('.main_link').click()
	
	$('#import_yahoo').live 'click', ->
		$(this).children('.main_link').click()
