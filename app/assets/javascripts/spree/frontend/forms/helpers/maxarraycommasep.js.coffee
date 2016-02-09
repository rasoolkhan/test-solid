$.validator.addMethod "maxarraycommasep", (value, element, params) ->
  if this.optional(element) then return true
  items = $(element).val().split(',')
  return false if items.length > params[0]
  items = items.map (item) ->
    item.trim()
  retVal = true
  for item in items
    retVal = false if item.length > params[1]
  retVal
, "Maximum of {0} tags. Each tag should be less than {1} characters."
