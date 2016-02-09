$.validator.addMethod "exactlength", (value, element, param) ->
	@.optional(element) || (value.length == param)
, $.format "Please enter exactly {0} characters."
