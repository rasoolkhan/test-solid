$.validator.addMethod "filesize", (value, element, param) ->
	retVal = false
	retVal = file.size > param for file in element.files
	!retVal
, "File is too large"
