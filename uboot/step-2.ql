/**
* @kind path-problem
*/

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

/*class MacroInvocationExpr extends Expr {
  // 2.0 Todo 
  predicate Instance(
}*/
 
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }
 
  override predicate isSource(DataFlow::Node source) {
    exists (MacroInvocation mi |
      mi
      .getMacroName()
      .regexpMatch("(ntohl|ntohll|ntohs)") 
      and
      mi.getExpr() = source.asExpr()
    )
  }
  override predicate isSink(DataFlow::Node sink) {
    exists (FunctionCall fc |
      fc.getTarget().getName() = "memcpy"
      and
      fc.getArgument(2) = sink.asExpr()
    )
  }
}
 
from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "ntoh flows to memcpy"
