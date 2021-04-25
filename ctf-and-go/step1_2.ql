import go

from EqualityTestExpr ete
where 
  ete.getLeftOperand().(Ident).getName() = "ErrNone"
  or
  ete.getRightOperand().(Ident).getName() = "ErrNone"
select ete, "Equality test expression with ErrNone!"

