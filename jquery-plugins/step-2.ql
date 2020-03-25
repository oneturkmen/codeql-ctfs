/**
 * @name Cross-site scripting vulnerable plugin
 * @kind path-problem
 * @id js/xss-unsafe-plugin
 */

import javascript
import semmle.javascript.frameworks.jQuery
import DataFlow::PathGraph

class Configuration extends TaintTracking::Configuration {
  Configuration() { this = "XssUnsafeJQueryPlugin" }

  override predicate isSource(DataFlow::Node source) {
    exists(
      DataFlow::FunctionNode f, DataFlow::ParameterNode param
      | jquery().getAPropertyRead("fn").getAPropertySource() = f and
      	source = f.getLastParameter()// and
      	//source = param.getAPropertyRead()
	)
  } // TODO: reuse 1.2

  override predicate isSink(DataFlow::Node sink) {
    exists(JQuery::MethodCall jcall | jcall.interpretsArgumentAsHtml(sink))
  } // TODO: reuse 0.2
}

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "Potential XSS vulnerability in plugin."

