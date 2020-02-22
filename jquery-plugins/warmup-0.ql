import javascript

from CallExpr dollarCall, Expr dollarArg
where
	dollarCall.getCalleeName() = "$" and
	dollarArg = dollarCall.getArgument(0)
select dollarArg, "This looks like the first argument to the Jquery '$'-function"
