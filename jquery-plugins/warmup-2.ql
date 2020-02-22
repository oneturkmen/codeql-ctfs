import javascript

from CallExpr dollarCall, Expr dollarArg, PropAccess optionsObject, PropAccess option
where
	dollarCall.getCalleeName() = "$" and
	dollarArg = dollarCall.getArgument(0) and
	optionsObject.getPropertyName() = "options" and
	option.getBase() = optionsObject and
	dollarArg = option
select dollarArg, "Using a jQuery plugin option as the argument"
				+ " to '$' may result in a cross-site scripting vulnerability"
