(* Coursera Programming Languages, Homework 3 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
let 
  val r = g f1 f2 
in
  case p of
      Wildcard          => f1 ()
    | Variable x        => f2 x
    | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
    | ConstructorP(_,p) => r p
    | _                 => 0
end

(**** for the challenge problem only ****)
datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** functions ****)
(*p1*)
val only_capitals = List.filter (Char.isUpper o (fn x => String.sub(x, 0)))

(*p2*)
val longest_string1 =
let
  fun longer_string (strA, strB) = 
    if String.size(strA) > String.size(strB)
    then strA
    else strB
in
  List.foldl longer_string "" 
end

(*p3*)
val longest_string2 = 
let
  fun longer_string (strA, strB) = 
    if String.size(strA) >= String.size(strB)
    then strA
    else strB
in
  List.foldl longer_string ""
end

(*p4*)
fun longest_string_helper compare = 
let
  fun longer_string (strA, strB) = 
    if compare(String.size(strA), String.size(strB))
    then strA
    else strB
in
  List.foldl longer_string ""
end

val longest_string3 = longest_string_helper (fn (x,y) => x > y) 
val longest_string4 = longest_string_helper (fn (x,y) => x >= y) 

(*p5*)
val longest_capitalized = longest_string1 o only_capitals 

(*p6*)
val rev_string = String.implode o List.rev o String.explode 

(*p7*)
fun first_answer f xs = 
  case xs of
      [] => raise NoAnswer
    | x::xs' => if isSome (f x) then valOf (f x)
                else first_answer f xs'

(*p8*)
fun all_answers f xs = 
let 
  fun helper f xs acc =
    case xs of
         [] => SOME acc
       | x::xs' => if isSome (f x) then helper f xs' (acc @ valOf (f x))
                   else NONE
in
  helper f xs []
end

(*p9*)
val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size x) 

fun count_some_var (s,p) = g (fn () => 0) (fn x => if x = s then 1 else 0) p 

(*p10*)
fun check_pat p =
let
  fun helper1 p = 
    case p of 
         Variable x          => [x]
       | TupleP ps           => List.foldl (fn (x,acc) => acc @ (helper1 x)) [] ps
       | ConstructorP (_, p) => helper1 p
       | _                   => [] 
  fun helper2 xs el =
    case xs of  
         [] => true
       | x::xs' => if List.exists (fn y => y = x) el then false
                   else helper2 xs' (x::el)
in
  helper2 (helper1 p) []
end

(*p11*)
fun match (v, p) = 
  case (v, p) of
       (_, Wildcard) => SOME []
     | (_, Variable s) => SOME [(s, v)] 
     | (Unit, UnitP) => SOME []
     | (Const x, ConstP c) => if x = c then SOME [] else NONE
     | (Tuple vs, TupleP ps) => if List.length ps = List.length vs 
                                then all_answers match (ListPair.zip(vs, ps))
                                else NONE
     | (Constructor(s2, vv), ConstructorP (s1, pp)) => if s1 = s2 
                                                       then match (vv, pp)
                                                       else NONE
     | (_, _) => NONE
                                 
(*p12*)
fun first_match v pl = 
  SOME ( first_answer (fn x => match(v, x)) pl)
  handle NoAnswer => NONE

(*challenge problem*)
fun typecheck_patterns sstList pList = 
let
  fun getDatatype (xs, c) =
    case xs of
         [] => ""
       | (cc, tt, v)::xs' => if cc = c then tt
                             else getDatatype(xs', c)
  fun typecheck p =
    case p of
         Wildcard => Anything
       | Variable _ => Anything
       | UnitP => UnitT
       | ConstP _ => IntT
       | TupleP [] => TupleT []
       | TupleP (pp::ps') =>
           let 
             val tt = typecheck pp
             val ttl = typecheck (TupleP ps')
           in
             case ttl of
                  TupleT x => TupleT (tt::x)
                | _ => raise NoAnswer
           end
       | ConstructorP (s, _) => if getDatatype (sstList, s) = "" then raise NoAnswer
                                else Datatype(getDatatype (sstList, s))
  fun getCommonType (t1, t2) =
    case (t1, t2) of
         (Anything, _) => t2
       | (_, Anything) => t1
       | (_, _) => if t1 = t2 then t1
                   else raise NoAnswer
in
  ( SOME (List.foldl getCommonType Anything (List.map typecheck pList)) )
  handle NoAnswer => NONE
end
