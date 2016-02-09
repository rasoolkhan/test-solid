$.validator.addMethod "filecountmax", (value, element, param) ->
	@.optional(element) || (element.files.length <= param)
, "Too many files selected."
