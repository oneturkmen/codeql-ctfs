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
    sink = any(DataFlow::EqualityTestNode etn | | etn.getLeftOperand())
    or
    sink = any(DataFlow::EqualityTestNode etn | | etn.getRightOperand())
  }
}


from 
  IsReqAuthFlowsToConditional cfg,
  DataFlow::PathNode source,
  DataFlow::PathNode sink,
  EqualityTestExpr ete,
  IfStmt ifs
where
  cfg.hasFlowPath(source, sink)
  and not ifs.getThen().getAStmt() instanceof ReturnStmt
  and ifs.getCond() = sink.getNode().asExpr().getParent()
  and (sink.getNode().asExpr().getParent().(EqualityTestExpr).getLeftOperand().(Ident).getName() = "ErrNone"
    or sink.getNode().asExpr().getParent().(EqualityTestExpr).getRightOperand().(Ident).getName() = "ErrNone")
select ifs, "This conditional gets flowed into from isReqAuthenticated"
