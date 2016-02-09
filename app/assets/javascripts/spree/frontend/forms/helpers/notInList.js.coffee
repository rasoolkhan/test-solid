$.validator.addMethod "notInList", (value, element, param) ->
	retVal = true
	if value
		$(param).each ->
			if @ != element
				if $(@).is('select') or $(@).is('input')
					retVal = false if value == $(@).val()
				else if $(@).is ''
					retVal = false if value == $(@).text()
	retVal
, "Value already taken"
