$.validator.addMethod "lettersandspacesandnocomma", (value, element) ->
	@.optional(element) || /^[a-z\s.&]+$/i.test(value)
, "Letters, spaces and '.' '&' only please."
