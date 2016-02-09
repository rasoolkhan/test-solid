$.validator.addMethod "lettersandspaces", (value, element) ->
	@.optional(element) || /^[a-z\s]+$/i.test(value)
, "Letters and spaces only please"
