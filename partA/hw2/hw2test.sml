(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw2.sml";

val test1 = all_except_option ("string", ["string"]) = SOME []
val test2 = all_except_option ("a", []) = NONE
val test3 = all_except_option ("a", ["ad", "a", "c"]) = SOME ["ad", "c"]
val test4 = all_except_option ("at", ["ad", "a", "c"]) = NONE

val test5 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test6 = get_substitutions1 ([["food", "foo"],["the", "foo"]], "foo") = ["food", "the"]
val test7 = get_substitutions1 ([["food", "foo"],["the", "foo"], ["a", "b"]], "foo") = ["food", "the"]
val test8 = get_substitutions1 ([[],[]], "foo") = []
val test9 = get_substitutions1 ([[],["foo"]], "foo") = []

val test10 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test11 = get_substitutions2 ([["food", "foo"],["the", "foo"]], "foo") = ["food", "the"]
val test12 = get_substitutions2 ([["food", "foo"],["the", "foo"], ["a", "b"]], "foo") = ["food", "the"]
val test13 = get_substitutions2 ([[],[]], "foo") = []
val test14 = get_substitutions2 ([[],["foo"]], "foo") = []


val test15 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test16 = similar_names ([["Tom","Thom","Tomm"],["Elizabeth","Betty"],["Freddie","Fred","F", "Tom"], ["Tom"]], {first="Tom", middle="W", last="Betty"}) =
	    [{first="Tom", last="Betty", middle="W"}, {first="Thom", last="Betty", middle="W"},
	     {first="Tomm", last="Betty", middle="W"}, {first="Freddie", last="Betty", middle="W"},
	     {first="Fred", last="Betty", middle="W"}, {first="F", last="Betty", middle="W"}]

val test17 = card_color (Clubs, Num 2) = Black
val test18 = card_color (Hearts, Num 3) = Red
val test19 = card_color (Spades, King) = Black
val test20 = card_color (Diamonds, Ace) = Red

val test21 = card_value (Clubs, Num 2) = 2
val test22 = card_value (Hearts, Num 3) = 3 
val test23 = card_value (Spades, King) = 10 
val test24 = card_value (Spades, Queen) = 10 
val test25 = card_value (Spades, Jack) = 10 
val test26 = card_value (Clubs, Num 10) = 10 
val test27 = card_value (Diamonds, Ace) = 11 


val test28 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test29 = remove_card ([(Hearts, Ace), (Clubs, King)], (Hearts, Ace), IllegalMove) = [(Clubs, King)]
val test30 = remove_card ([(Hearts, Ace), (Clubs, King)], (Clubs, King), IllegalMove) = [(Hearts, Ace)]

val test31 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test32 = all_same_color [(Hearts, Ace), (Clubs, Ace)] = false
val test33 = all_same_color [] = true 
val test34 = all_same_color [(Clubs, Ace), (Clubs, Ace)] = true
val test35 = all_same_color [(Clubs, Ace), (Spades, Ace), (Clubs, Num 10), (Clubs, King), (Spades, Jack)] = true
val test36 = all_same_color [(Clubs, Ace), (Spades, Ace), (Clubs, Num 10), (Clubs, King), (Hearts, Jack)] = false 

val test37 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test38 = sum_cards [] = 0

val test39 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test40 = score ([(Hearts, Num 2),(Clubs, Num 4)],1) = 15
val test41 = score ([(Hearts, Num 2),(Diamonds, Num 4)],10) = 2

val test42 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test43 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test45 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test46 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        42)
             = 3

val test47 = officiate ([(Clubs,Ace),(Hearts,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        42)
             = 6

val test48 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             

val test49 = ((officiate ([],
                        [Discard(Hearts, King)],
                        1);
                
               false) 
              handle IllegalMove => true)

val test50 = officiate ([],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        0)
             = 0
            

val test51 = score_challenge([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test52 = score_challenge([(Hearts, Num 2),(Clubs, Num 4)],1) = 15
val test53 = score_challenge([(Hearts, Num 2),(Diamonds, Num 4)],10) = 2
val test54 = score_challenge([(Hearts, Ace),(Clubs, Ace)],10) = 6
val test55 = score_challenge([(Hearts, Ace),(Clubs, Ace)],20) = 6
val test56 = score_challenge([(Hearts, Ace),(Clubs, Ace)],2) = 0


val test57 = officiate_challenge ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test58 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test59 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test60 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        42)
             = 3

val test61 = officiate_challenge ([(Clubs,Ace),(Hearts,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        42)
             = 6

val test62 = ((officiate_challenge([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             

val test63 = ((officiate_challenge ([],
                        [Discard(Hearts, King)],
                        1);
                
               false) 
              handle IllegalMove => true)

val test64 = officiate_challenge ([],
                        [Draw,Draw,Draw,Draw,Discard(Hearts, King)],
                        0)
             = 0

val test65 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts,King)],




                        [Draw,Draw,Draw,Draw,Draw],
                        44)
             = 0

val test66 = careful_player([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts, Num 2)], 42)
             = [Draw, Draw, Draw]

val test67 = careful_player([], 8)
             = []
             
val test68 = careful_player([], 11)
             = [Draw]

val test69 = careful_player([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Hearts,Num 2)], 44)
             = [Draw, Draw, Draw, Draw]

val test70 =
  careful_player([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Num 2),(Hearts,Ace)], 44)
             = [Draw, Draw, Draw, Draw, Discard(Spades, Num 2), Draw]
