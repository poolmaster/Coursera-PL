(*Coursera PL partA*)
(*hw2*)

(*problem 1*)
(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (str, strList) =
  let 
    fun aux(ss, ssList, inList, exList) = 
      case (inList, ssList) of  
        (true, _) => SOME (exList @ ssList)
      | (false, []) => NONE
      | (false, hss::ssList') => if same_string(hss, ss) then aux(ss, ssList', true, exList) 
                                 else aux(ss, ssList', false, exList @ [hss]) 
  in 
    aux(str, strList, false, [])
  end

fun get_substitutions1 (subLists, str) =
  case subLists of
      [] => [] 
    | hd::subLists' => 
        case all_except_option(str, hd) of
            NONE => get_substitutions1(subLists', str)
          | SOME x => x @ get_substitutions1(subLists', str)

fun get_substitutions2 (subLists, str) =
  let 
    fun aux(sl, ss, accum) = 
      case sl of
          [] => accum
        | hd::sl' =>
            case all_except_option(ss, hd) of
                NONE => aux(sl', ss, accum)
              | SOME x => aux(sl', ss, accum @ x) 
  in
    aux(subLists, str, [])
  end

fun similar_names (subLists, fullName) = 
  let
    fun replace(subList, fullName) =
      case subList of
          [] => []
        | hd::subList' => 
            case fullName of 
              {first=a, middle=b, last=c} => [{first=hd, middle=b, last=c}] @ replace(subList',fullName) 
  in
    case fullName of 
      {first=a, middle=b, last=c} => fullName::replace(get_substitutions2(subLists, a), fullName)
  end


(*problem 2*)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color (Clubs, rank) = Black
  | card_color (Diamonds, rank) = Red 
  | card_color (Hearts, rank) = Red 
  | card_color (Spades, rank) = Black 

fun card_value (suit, Ace) = 11
  | card_value (suit, King) = 10
  | card_value (suit, Jack) = 10
  | card_value (suit, Num(value)) = value
  | card_value (suit, Queue) = 10

fun remove_card ([], c, e) = raise e
  | remove_card (hd::cl, c, e) = 
    if hd = c then cl 
    else hd::remove_card(cl, c, e)

fun all_same_color ([]) = true
  | all_same_color (first::[]) = true 
  | all_same_color (first::second::[]) = card_color(first) = card_color(second)
  | all_same_color (first::second::ll) = all_same_color([first, second]) andalso all_same_color(second::ll)
          
fun sum_cards (cardList) = 
  let
    fun aux ([], accum) = accum
      | aux (hd::cl, accum) = aux(cl, card_value(hd) + accum)
  in
    aux(cardList, 0)
  end
      
fun score (cardList, goal) = 
  let 
    val sum = sum_cards(cardList)
    val pre = if sum > goal then 3 * (sum - goal) else goal - sum
  in 
    if all_same_color(cardList) then pre div 2
    else pre
  end

fun officiate (cardList, moveList, goal) = 
  let
    (* aux(cardList, moveList, heldList, goal) *)
    fun aux(_, [], heldList, goal) = score(heldList, goal)
      | aux(cardList, Discard(dCard)::moveList', heldList, goal) = aux(cardList, moveList', remove_card(heldList, dCard, IllegalMove), goal)
      | aux([], Draw::moveList', heldList, goal) = score(heldList, goal)
      | aux(drawCard::cardList', Draw::moveList', heldList, goal) = if sum_cards(drawCard::heldList) > goal then score(drawCard::heldList, goal)
                                                                    else aux(cardList', moveList', drawCard::heldList, goal)
  in
    aux(cardList, moveList, [], goal)
  end

(*problem 3 challenge*)
fun score_challenge (cardList, goal) = 
  let 
    fun countAces ([], accum) = accum
      | countAces (hd::cList, accum) = countAces(cList, accum + (if card_value(hd) = 11 then 1 else 0))
    fun getOpt (sum, cntAce, goal) = 
      if cntAce > 0 andalso sum - goal >= 10 then getOpt(sum - 10, cntAce - 1, goal)
      else if sum > goal then 3 * (sum - goal)
      else goal - sum

    val sum11 = sum_cards(cardList)
    val pre = getOpt(sum11, countAces(cardList, 0), goal) 

  in 
    if all_same_color(cardList) then pre div 2
    else pre
  end

fun officiate_challenge (cardList, moveList, goal) = 
  let
    (* aux(cardList, moveList, heldList, goal) *)
    fun aux(_, [], heldList, goal) = score_challenge(heldList, goal)
      | aux(cardList, Discard(dCard)::moveList', heldList, goal) = aux(cardList, moveList', remove_card(heldList, dCard, IllegalMove), goal)
      | aux([], Draw::moveList', heldList, goal) = score_challenge(heldList, goal)
      | aux(drawCard::cardList', Draw::moveList', heldList, goal) = if sum_cards(drawCard::heldList) > goal then score_challenge(drawCard::heldList, goal)
                                                                    else aux(cardList', moveList', drawCard::heldList, goal)
  in
    aux(cardList, moveList, [], goal)
  end

fun careful_player (cardList, goal) = 
  let 
    (* fun getCardByValue(cl, v) *) 
    fun getCardByValue([], v) = NONE
      | getCardByValue(hd::cl, v) = 
          if card_value(hd) = v then SOME hd
          else getCardByValue(cl, v) 
  (* aux(cardList, moveList, heldList, goal) *)
    fun aux([], moveList, heldList, goal) =
          if goal - 10 > sum_cards(heldList)
          then moveList @ [Draw]
          else moveList
      | aux(hd::cl, moveList, heldList, goal) = 
          if goal >= sum_cards(hd::heldList) then aux(cl, moveList @ [Draw], hd::heldList, goal)
          else if goal = sum_cards(heldList) then moveList
          else let
            val dCard = getCardByValue(heldList, sum_cards(hd::heldList) - goal)      
          in 
            case dCard of
                NONE => moveList
              | SOME x => aux(hd::cl, moveList @ [Discard(x)], remove_card(heldList, x, IllegalMove), goal)
          end
  in
    aux(cardList, [], [], goal)
  end

