# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#contact_form_submit').live 'click', ->
		submit = $(this)
		form = submit.parents().find('form')
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
		
	$('#contact_id_toggle').live 'click', ->
		checked = false
		if $('#contact_id_toggle').is(':checked')
			if $('.contact_id_checkbox').size() != $('.contact_id_checkbox:checked').size()
				$('.contact_id_checkbox').attr('checked',true)
			else
				$('.contact_id_checkbox').attr('checked',false)
		else
			$('.contact_id_checkbox').attr('checked',false)
			
	$('#contact_delete').live 'click', ->
		if $('.contact_id_checkbox:checked').size() == 0
			add_activity('Select the contacts you want to delete')
		else
			ids = new Array()
			$('.contact_id_checkbox:checked').each ->
				ids.push($(this).val())
			$('#contact_delete_ids').val(ids)
			$('#contact_delete_form').submit()
			add_activity('Confirm to delete selected contacts')
			