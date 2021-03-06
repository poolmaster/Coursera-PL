(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw3.sml";

val test1_0 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1_1 = only_capitals ["Ak","b","c"] = ["Ak"]
val test1_2 = only_capitals ["tt","bB","Ctt"] = ["Ctt"]
val test1_3 = only_capitals [] = []
val test1_4 = only_capitals ["aaa","bBBBB","cPPPP"] = []

val test2_0 = longest_string1 ["A","bc","C"] = "bc"
val test2_1 = longest_string1 ["Aa","bc","C"] = "Aa"
val test2_2 = longest_string1 ["Aa","b","Cttt"] = "Cttt"
val test2_3 = longest_string1 ["A","bc","Ck"] = "bc"

val test3_0 = longest_string2 ["A","bc","C"] = "bc"
val test3_1 = longest_string2 ["Aa","bc","C"] = "bc"
val test3_2 = longest_string2 ["Aa","bkkk","Cttt"] = "Cttt"
val test3_3 = longest_string2 ["Aatttt","bkkk","Cttt"] = "Aatttt"

val test4_0 = longest_string3 ["A","bc","C"] = "bc"
val test4_1 = longest_string3 ["Aa","bc","C"] = "Aa"
val test4_2 = longest_string3 ["Aa","b","Cttt"] = "Cttt"
val test4_3 = longest_string3 ["A","bc","Ck"] = "bc"
val test4_4 = longest_string4 ["A","bc","C"] = "bc"
val test4_5 = longest_string4 ["Aa","bc","C"] = "bc"
val test4_6 = longest_string4 ["Aa","bkkk","Cttt"] = "Cttt"
val test4_7 = longest_string4 ["Aatttt","bkkk","Cttt"] = "Aatttt"

val test5_0 = longest_capitalized ["A","bc","C"] = "A"
val test5_1 = longest_capitalized ["t","bc","kk"] = ""
val test5_2 = longest_capitalized ["Abc","bCiiiiii","Ktr", "Oracle"] = "Oracle"
val test5_3 = longest_capitalized ["YongLi", "Abc","bCiiiiii","Ktr", "Oracle"] = "YongLi"

val test6_0 = rev_string "abc" = "cba"
val test6_1 = rev_string "a" = "a"
val test6_2 = rev_string "ac" = "ca"
val test6_3 = rev_string "" = ""

val test7_0 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7_1 = ((first_answer (fn x => if x > 6 then SOME x else NONE) [1,2,3,4,5]; 
                false) 
               handle NoAnswer => true)
val test7_2 = first_answer (fn x => if x = "a" then SOME x else NONE) ["b","c","a"] = "a" 
val test7_3 = first_answer (fn x => if x > 2 then SOME x else NONE) [1,2,3,4,5] = 3

val test8_0 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8_1 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,3,4,5,6,7] = NONE
val test8_2 = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7] 

val test9a_0 = count_wildcards Wildcard = 1
val test9a_1 = count_wildcards (TupleP [Wildcard, Wildcard]) = 2
val test9a_2 = count_wildcards (TupleP [Wildcard, Wildcard, TupleP [Variable "x", UnitP, Wildcard], ConstP 18]) = 3
val test9a_3 = count_wildcards (Variable "y") = 0
val test9a_4 = count_wildcards (ConstP 9) = 0
val test9a_5 = count_wildcards UnitP = 0
val test9a_6 = count_wildcards (ConstructorP ("ok", Wildcard)) = 1
val test9a_7 = count_wildcards (TupleP [Wildcard, 
                                     Wildcard, 
                                     TupleP [Variable "x",
                                             UnitP, 
                                             Wildcard], 
                                     ConstP 18, 
                                     TupleP [UnitP, UnitP], 
                                     TupleP [ConstructorP ("no", Wildcard)]]) = 4

val test9b_0 = count_wild_and_variable_lengths Wildcard = 1
val test9b_1 = count_wild_and_variable_lengths (TupleP [Wildcard, Wildcard]) = 2
val test9b_2 = count_wild_and_variable_lengths (TupleP [Wildcard, Wildcard, TupleP [Variable "x", UnitP, Wildcard], ConstP 18]) = 4
val test9b_3 = count_wild_and_variable_lengths (TupleP [Wildcard, Wildcard, TupleP [Variable "xyy", UnitP, Wildcard], ConstP 18]) = 6
val test9b_4 = count_wild_and_variable_lengths (Variable "ykkk") = 4
val test9b_5 = count_wild_and_variable_lengths (ConstP 9) = 0
val test9b_6 = count_wild_and_variable_lengths UnitP = 0
val test9b_7 = count_wild_and_variable_lengths (ConstructorP ("ok", Wildcard)) = 1
val test9b_8 = count_wild_and_variable_lengths (TupleP [Wildcard, 
                                                        Wildcard, 
                                                        TupleP [Variable "xb",
                                                                UnitP, 
                                                                Wildcard], 
                                                        ConstP 18, 
                                                        Variable "kk",
                                                        TupleP [UnitP, UnitP], 
                                                        TupleP [ConstructorP ("no", Wildcard)]]) = 8
val test9b_9 = count_wild_and_variable_lengths (Variable("a")) = 1


val test9c_0 = count_some_var ("x", Variable("x")) = 1
val test9c_1 = count_some_var ("x", UnitP) = 0
val test9c_2 = count_some_var ("x", ConstP 10) = 0
val test9c_3 = count_some_var ("sb", TupleP [Wildcard, 
                                             Variable "sb", 
                                             TupleP [Variable "sb",
                                                     UnitP, 
                                                     Wildcard], 
                                             ConstP 18, 
                                             Variable "nb",
                                             TupleP [UnitP, UnitP], 
                                             TupleP
                                             [ConstructorP("sb", Wildcard)]]) = 2
val test9c_4 = count_some_var ("nb", TupleP [Wildcard, 
                                             Variable "sb", 
                                             TupleP [Variable "nb",
                                                     UnitP, 
                                                     Wildcard], 
                                             ConstP 18, 
                                             Variable "sb",
                                             TupleP [UnitP, UnitP], 
                                             TupleP
                                             [ConstructorP("sb", Variable "nb")]]) = 2 

val test10_0 = check_pat (Variable("x")) = true
val test10_1 = check_pat (UnitP) = true
val test10_2 = check_pat (TupleP [Variable "xx", Variable "xx"]) = false
val test10_3 = check_pat (TupleP [Variable "xx", Variable "wt", Variable "wt"]) = false
val test10_4 = check_pat (TupleP [Variable "xx", Variable "wt", Variable "we"]) = true
val test10_5 = check_pat (TupleP [Wildcard, 
                                  Variable "sb", 
                                  TupleP [Variable "nb",
                                          UnitP, 
                                          Wildcard], 
                                  ConstP 18, 
                                  Variable "tb",
                                  TupleP [UnitP, UnitP], 
                                  TupleP
                                  [ConstructorP("nb", Wildcard)]]) = true

val test11_0 = match (Const(1), Wildcard) = SOME []
val test11_1 = match (Unit, Wildcard) = SOME []
val test11_2 = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], Wildcard) = SOME []
val test11_3 = match (Constructor("newtype", Unit), Wildcard) = SOME []

val test11_4 = match (Const(2), Variable "pname") = SOME [("pname", Const(2))]
val test11_5 = match (Unit, Variable "pname") = SOME [("pname", Unit)]
val test11_6 = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], Variable "pname") = SOME [("pname", Tuple[Unit, Const(1), Constructor("newtype", Unit)])]
val test11_7 = match (Constructor("newtype", Unit), Variable "pname") = SOME [("pname", Constructor("newtype", Unit))]

val test11_8 = match (Const(1), UnitP) = NONE 
val test11_9 = match (Unit, UnitP) = SOME []
val test11_a = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], UnitP) = NONE 
val test11_b = match (Constructor("newtype", Unit), UnitP) = NONE 

val test11_c = match (Const(1), ConstP(7)) = NONE 
val test11_d = match (Const(7), ConstP(7)) = SOME []
val test11_e = match (Unit, ConstP(7)) = NONE 
val test11_f = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], ConstP(7)) = NONE 
val test11_g = match (Constructor("newtype", Unit), ConstP(7)) = NONE 

val test11_h = match (Const(7), TupleP[ConstP(7)]) = NONE
val test11_i = match (Unit, TupleP[UnitP]) = NONE 
val test11_j = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], TupleP[UnitP, ConstP(1), Wildcard] ) = SOME [] 
val test11_k = match (Tuple[Unit, Constructor("newtype", Unit)], TupleP[UnitP, ConstP(1), Wildcard] ) = NONE
val test11_l = match (Constructor("newtype", Unit), TupleP[ConstructorP("newtype", UnitP)]) = NONE

val test11_m = match (Const(7), ConstructorP("newType", UnitP)) = NONE
val test11_n = match (Unit, ConstructorP("newType", UnitP)) = NONE 
val test11_o = match (Tuple[Unit, Const(1), Constructor("newtype", Unit)], ConstructorP("newType", UnitP) ) = NONE 
val test11_p = match (Constructor("newType", Unit), ConstructorP("newType", UnitP)) = SOME []
val test11_q = match (Constructor("oldType", Unit), ConstructorP("newType", UnitP)) = NONE
val test11_r = match (Constructor("oldType", Unit), ConstructorP("oldType", Variable "ok")) = SOME [("ok", Unit)]
val test11_s = match (Constructor("oldType", Tuple[]), ConstructorP("oldType", TupleP[])) = SOME []

val test11_t = match (Constructor("oldType", Tuple[Unit, Unit, Const(7)]), ConstructorP("oldType", TupleP[Variable "a", Variable "b", Variable "c"])) 
           = SOME [("a", Unit), ("b", Unit), ("c", Const(7))]

val test12_0 = first_match (Const 1) [Wildcard, Variable "a"] = SOME []
val test12_1 = first_match (Unit) [Wildcard] = SOME []
val test12_2 = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [Wildcard] = SOME []
val test12_3 = first_match (Constructor("newtype", Unit)) [Wildcard] = SOME []

val test12_4 = first_match (Const(2)) [Variable "pname"] = SOME [("pname", Const(2))]
val test12_5 = first_match (Unit) [Variable "pname"] = SOME [("pname", Unit)]
val test12_6 = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [Variable "pname"] = SOME [("pname", Tuple[Unit, Const(1), Constructor("newtype", Unit)])]
val test12_7 = first_match (Constructor("newtype", Unit)) [Variable "pname"] = SOME [("pname", Constructor("newtype", Unit))]

val test12_8 = first_match (Const(1)) [UnitP] = NONE 
val test12_9 = first_match (Unit) [UnitP] = SOME []
val test12_a = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [UnitP] = NONE 
val test12_b = first_match (Constructor("newtype", Unit)) [UnitP] = NONE 

val test12_c = first_match (Const(1)) [ConstP(7)] = NONE 
val test12_d = first_match (Const(7)) [ConstP(7)] = SOME []
val test12_e = first_match (Unit) [ConstP(7)] = NONE 
val test12_f = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [ConstP(7)] = NONE 
val test12_g = first_match (Constructor("newtype", Unit)) [ConstP(7)] = NONE 

val test12_h = first_match (Const(7)) [TupleP[ConstP(7)]] = NONE
val test12_i = first_match (Unit) [TupleP[UnitP]]  = NONE 
val test12_j = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [TupleP[UnitP, ConstP(1), Wildcard]] = SOME [] 
val test12_k = first_match (Tuple[Unit, Constructor("newtype", Unit)]) [TupleP[UnitP, ConstP(1), Wildcard]] = NONE
val test12_l = first_match (Constructor("newtype", Unit)) [TupleP[ConstructorP("newtype", UnitP)]] = NONE

val test12_m = first_match (Const(7)) [ConstructorP("newType", UnitP)] = NONE
val test12_n = first_match (Unit) [ConstructorP("newType", UnitP)] = NONE 
val test12_o = first_match (Tuple[Unit, Const(1), Constructor("newtype", Unit)]) [ConstructorP("newType", UnitP)] = NONE 
val test12_p = first_match (Constructor("newType", Unit)) [ConstructorP("newType", UnitP)] = SOME []
val test12_q = first_match (Constructor("oldType", Unit)) [ConstructorP("newType", UnitP)] = NONE

val test12_t = first_match (Constructor("oldType", Tuple[Unit, Unit, Const(7)])) [ConstructorP("oldType", TupleP[Variable "a", Variable "b", Variable "c"])] 
             = SOME [("a", Unit), ("b", Unit), ("c", Const(7))]
val test12_u = first_match Unit [UnitP, UnitP] = SOME []


val test13_0 = typecheck_patterns [] [TupleP[Variable("X"),Variable("Y")], TupleP[Wildcard, Wildcard]] 
             = SOME (TupleT[Anything, Anything])
val test13_1 = typecheck_patterns [] [TupleP[Variable("X"),Variable("Y")], UnitP] 
             = NONE
val test13_2 = typecheck_patterns [("foo", "bar", IntT)] [ConstructorP("foo", UnitP)] 
             = SOME (Datatype("bar"))
val test13_3 = typecheck_patterns [("foo", "bar", IntT), ("hoo", "bar", IntT)] [ConstructorP("foo", UnitP), ConstructorP("hoo", Variable "a")] 
             = SOME (Datatype("bar"))
val test13_4 = typecheck_patterns [("foo", "bar", IntT), ("hoo", "tar", IntT)] [ConstructorP("foo", UnitP), ConstructorP("hoo", Variable "a")] 
             = NONE
