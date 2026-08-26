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


fun lookup (table, id) =
    case table of
        [] => raise Fail "variable not found"
    | (id1, v1)::rest => if (id = id1) then v1 else lookup(rest, id)

fun update (table, id, int) =
    (id, int)::table;

(* testing for update()*)
val t0 : (string * int) list = [];
val t1 = update(t0, "a", 3);
val t2 = update(t1, "c", 4);


fun interpStm 
    (CompoundStm(s1, s2), table) = 
        let
            val table1 = interpStm (s1, table)
        in
            interpStm (s2, table1)
        end

    | interpStm (AssignStm(id, e), table) =
        let
            val (v, table1) = interpExp(e, table)
        in
            update(table1,id, v)
        end
    
    | interpStm (PrintStm(expList), table) = 
        let
            val table1 = interpExpList(expList, table)
        in
            (print "\n"; table1)
        end
        


fun interpExp (IdExp id, table) = (lookup(table, id), table)
    |   interpExp (NumExp n, table) = (n, table)
    |   interpExp (OpExp(e1, oper, e2), table) = 
            let
              val (v1, table1) = interpExp (e1, table)
              val (v2, table2) = interpExp (e2, table1)
            in
                (case oper of
                    Plus => (v1 + v2)
                    | Minus => (v1 - v2)
                    | Times => (v1 * v2)
                    | Div => (v1 div v2)
                table2)
            end
    |   interpExp (EseqExp(s, e), table) = 
        let
          val table1 = interpStm (s, table)
          val (v2, table2) = interpExp (e, table1)
        in
          (v2, table2)
        end

fun interpExpList (expList, table) =
    case expList of
        [] => table
    | e::rest => 
        let
          val (v, table1) = interpExp(expList, table)
        in
          (print(Int.toString v); interpExpList(rest, table1))
        end

fun interp () =
    