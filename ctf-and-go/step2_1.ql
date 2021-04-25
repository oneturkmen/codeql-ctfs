/**
 * @name Empty block
 * @kind problem
 * @problem.severity warning
 * @id go/example/empty-block
 */



import go


class IsReqAuthFlowsToConditional extends DataFlow::Configuration {
  IsReqAuthFlowsToConditional() { this = "IsReqAuthFlowsToConditional" }

  override predicate isSource(DataFlow::Node source) {
    source instanceof DataFlow::CallNode
    and
    source.(DataFlow::CallNode).getTarget().getName() = "isReqAuthenticated"
  }

  override predicate isSink(DataFlow::Node sink) {
    // sink instanceof DataFlow::EqualityTestNode
    exists(DataFlow::EqualityTestNode etn | etn.getLeftOperand() = sink or etn.getRightOperand() = sink)
  }
}


from IsReqAuthFlowsToConditional cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink.getNode(), "This conditional gets flowed into from isReqAuthenticated"