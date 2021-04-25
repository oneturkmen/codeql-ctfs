import go

from IfStmt ifs
where 
  not ifs.getThen().getAStmt() instanceof ReturnStmt
select ifs, "If then without return statement!!"
