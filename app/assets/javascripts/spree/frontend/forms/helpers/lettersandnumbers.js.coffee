$.validator.addMethod "lettersandnumbers", (value, element) ->
	@.optional(element) || /^[a-z0-9]+$/i.test(value)
, "Letters and numbers only please"
