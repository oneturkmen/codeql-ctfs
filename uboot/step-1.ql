import cpp

from MacroInvocation mi
where mi.getMacroName().regexpMatch("(ntohl|ntohll|ntohs)")
select mi.getExpr()
