type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end


%% 
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
","	=> (Tokens.COMMA(yypos,yypos+1));
" "  	=> (Tokens.VAR(yypos,yypos+3));
"123"	=> (Tokens.INT(123,yypos,yypos+3));
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
while => (Tokens.WHILE(yypos, yypos+5));
for => (Tokens.FOR(yypos, yypos+3));
to => (Tokens.TO(yypos, yypos+2))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))
break => (Tokens.BREAK(yypos, yypos+5))


