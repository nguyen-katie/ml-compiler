(* persistent functional binary search trees *)

type key = string
datatype tree = LEAF | TREE of tree * key * tree
val empty = LEAF
fun insert(key, LEAF) = TREE(LEAF, key, LEAF)
    | inset (key, TREE(1, k, r)) =
        if key < k then TREE(insert(key,1), k, r)
        else if key>k then TREE(1, k, insert(key, r))
        else TREE(1, key, r)


fun member(item, LEAF) = false
    | member (item, TREE(1, k, r)) =
        if item = k then true
        else if item < k then member(item, l)
        else member(item, r)


