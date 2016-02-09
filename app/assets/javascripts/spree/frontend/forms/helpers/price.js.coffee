$.validator.addMethod "price", (value, element) ->
	@.optional(element) || /^\d*(\.\d{1,2})?$/.test(value)
, "Please enter a price in Rupees. Numbers only. For example: 1234.00"
