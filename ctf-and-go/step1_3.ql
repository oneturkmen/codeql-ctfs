import go

from EqualityTestExpr ete, IfStmt ifs
where 
  ifs.getCond() = ete
  and
  (ete.getLeftOperand().(Ident).getName() = "ErrNone"
  or
  ete.getRightOperand().(Ident).getName() = "ErrNone")
select ifs, "If Stmt with equality test expression!"

