type id = string

datatype binop = Plus | Minus | Times | Div

datatype stm = CompoundStm of stm * stm
| AssignStm of id * exp
| PrintStm of exp list

and exp = IdExp of id | NumExp of int | OpExp of exp * binop * exp | EseqExp of stm * exp


(* Exercise 1 *)
val prog =
    CompoundStm(AssignStm("a", OpExp(NumExp 5, Plus, NumExp 3)),
        CompoundStm(AssignStm("b",
            EseqExp(PrintStm[IdExp "a", OpExp(IdExp "a", Minus,
            NumExp 1)],
            OpExp(NumExp 10, Times, IdExp"a"))),
            PrintStm[IdExp"b"]));



fun maxargs (CompoundStm(s1, s2)) = Int.max(maxargs s1, maxargs s2)
    | maxargs (AssignStm(id, e)) = maxargsExp e
    | maxargs (PrintStm(expList)) = 
        Int.max(length expList, foldl Int.max 0 (map maxargsExp expList))

and maxargsExp (IdExp _) = 0
    |   maxargsExp (NumExp _) = 0
    |   maxargsExp (OpExp(e1, _, e2)) = Int.max(maxargsExp e1, maxargsExp e2)
    |   maxargsExp (EseqExp(s, e)) = Int.max(maxargsExp e, maxargs s)

(* Exercise 2: Interpreter *)
(* fun interp (stm) =  *)

fun lookup (table, id) =
    case table of
        [] => raise Fail "variable not found"
    | (id1, v1)::rest => if (id = id1) then v1 else lookup(rest, id)