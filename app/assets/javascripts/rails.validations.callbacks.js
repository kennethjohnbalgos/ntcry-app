ClientSideValidations.callbacks.element.fail = function(element, message, callback) {
	
	message = message[0].toUpperCase() + message.substr(1).toLowerCase();
	error_container = element.parent().parent().children('.error_space');
	field_container = element.parent().children('.field_space');
	
	// Change field border color
	element.css('border','1px solid #C00');
	
	// Replace contents
	error_container.html(message);
	field_container.html(element);
	
	validate_fields(element.parents().find('form'));
}

ClientSideValidations.callbacks.element.pass = function(element, callback) {
	error_container = element.parent().parent().children('.error_space');
	field_container = element.parent().children('.field_space');
	
	// Change field border color
	element.css('border','1px solid #CCC');
	
	// Replace contents
	error_container.html('');
	field_container.html(element);
	
	validate_fields(element.parents().find('form'));
}