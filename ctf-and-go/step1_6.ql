import go

from EqualityTestExpr ete, IfStmt ifs
where 
  not ifs.getThen().getAStmt() instanceof ReturnStmt
  and
  ifs.getCond() = ete
  and
  (ete.getLeftOperand().(Ident).getName() = "ErrNone"
  or
  ete.getRightOperand().(Ident).getName() = "ErrNone")
select ifs, "If blocks tests ErrNone and no return!"

