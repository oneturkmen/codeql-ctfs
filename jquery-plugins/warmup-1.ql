import javascript

from PropAccess optionsObject, PropAccess option
where
	optionsObject.getPropertyName() = "options" and
        option.getBase() = optionsObject
select option, "This looks like a jQuery plugin option."
