import javascript

/**
 * Q1.3: Write a simple query that finds the property reads of the options object, 
 * for example options.textSrcSelector from the above example
 */
from DataFlow::FunctionNode f, DataFlow::ParameterNode param, DataFlow::PropRead prop
where 
	jquery().getAPropertyRead("fn").getAPropertySource() = f and
	param = f.getLastParameter() and
	prop = param.getAPropertyRead()
select prop

