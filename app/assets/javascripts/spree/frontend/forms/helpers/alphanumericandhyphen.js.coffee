$.validator.addMethod "alphanumericandhyphen", (value, element) ->
	@.optional(element) || /^[a-z0-9-]+$/.test(value)
, "lowercase letters and hyphens only"
