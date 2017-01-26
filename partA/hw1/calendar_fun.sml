(*Coursera PL partA*)
(*hw1*)

(* return true if first date is older *)
fun is_older (date0 : int*int*int, date1: int*int*int) = 
  if (#1 date0) <> (#1 date1)
  then (#1 date0) < (#1 date1)
  else if (#2 date0) <> (#2 date1)
  then (#2 date0) < (#2 date1)
  else (#3 date0) < (#3 date1)

(*return number of dataes from a list in a month*)
fun number_in_month (dList : (int*int*int) list, month : int) = 
  if (null dList)
  then 0
  else 
    if (#2 (hd dList)) = month
    then number_in_month((tl dList), month) + 1
    else number_in_month((tl dList), month)

(*like previous one but handle list of months*)
fun number_in_months (dList : (int*int*int) list, mList : int list) = 
  if (null mList)
  then 0
  else number_in_month(dList, (hd mList)) + number_in_months(dList, (tl mList))

(*return a list of dates which in a month*)
(*NOTE: keep date order in the original list*)
fun dates_in_month (dList : (int*int*int) list, month : int) = 
  if (null dList)
  then []
  else if (#2 (hd dList)) = month
  then (hd dList) :: dates_in_month((tl dList), month)
  else dates_in_month((tl dList), month)

(*similar to previous problem*)
fun dates_in_months (dList : (int*int*int) list, mList : int list) = 
  if (null mList)
  then []
  else dates_in_month(dList, (hd mList)) @ dates_in_months(dList, (tl mList)) 

(*get nth string in a list*)
fun get_nth (sList : string list, n : int) =
  (*if (null sList) orelse n = 0 then NONE*)
  if n = 0
  then ""
  else if (null (tl sList)) orelse n = 1
  then (hd sList)
  else get_nth((tl sList), n - 1) 

(* date to string *)
fun date_to_string (date : int*int*int) = 
  let 
    val mList = ["January", "February", "March", "April", "May", "June", "July",
       "August", "September", "October", "November", "December"]
    val year = Int.toString(#1 date)
    val month = get_nth(mList, (#2 date))
    val day = Int.toString(#3 date)
  in
    month ^ " " ^ day ^ ", " ^ year
  end

(* sum of first n < sum, sum of first n+1 > sum*)
fun number_before_reaching_sum (sum : int, intList : int list) = 
  if null intList
  then 1
  else if (hd intList) >= sum
  then 0
  else number_before_reaching_sum(sum - (hd intList), (tl intList)) + 1 

(* return month of a day as a int *)
fun what_month (day : int) = 
  let
    val numOfDayInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] 
  in   
    number_before_reaching_sum(day, numOfDayInMonth) + 1
  end
  
(* return a list of months between 2 days, inclusive*)  
fun month_range (day1 : int, day2 : int) = 
  if day1 > day2 
  then []
  else if day1 = day2
  then [what_month(day1)]
  else what_month(day1) :: month_range(day1 + 1, day2)

(*find the oldest date, with int option*)
fun oldest (dateList : (int*int*int) list) = 
  if null dateList
  then NONE
  else if null (tl dateList)
  then SOME (hd dateList) 
  else
    let
      val oldestTl = oldest(tl dateList)
    in
      if is_older((hd dateList), valOf(oldestTl))
      then SOME (hd dateList)
      else oldestTl
    end

(* challenge handling duplicates on month*)
fun isInList (element : int, eList : int list) = 
  if null eList
  then false
  else if element = hd eList
  then true
  else isInList(element, (tl eList))
  
fun number_in_months_helper (dList : (int*int*int) list, mList : int list, dupList : int list) =
  if null mList
  then 0
  else if not (isInList((hd mList), dupList)) 
  then number_in_month(dList, (hd mList)) + number_in_months_helper(dList, (tl mList), ((hd mList) :: dupList))
  else number_in_months_helper(dList, (tl mList), dupList)

fun number_in_months_challenge (dList : (int*int*int) list, mList : int list) = 
  number_in_months_helper (dList, mList, []) 

(*similar to previous problem*)
fun dates_in_months_helper (dList : (int*int*int) list, mList : int list, dupList : int list) = 
  if null mList
  then []
  else if not (isInList((hd mList), dupList))
  then dates_in_month(dList, (hd mList)) @ dates_in_months_helper(dList, (tl mList), ((hd mList) :: dupList))
  else dates_in_months_helper(dList, (tl mList), dupList)

fun dates_in_months_challenge (dList : (int*int*int) list, mList : int list) = 
  dates_in_months_helper (dList, mList, [])

(*tell if a date exist*)
fun isLeapYear (year : int) = 
  if year mod 400 = 0
  then true
  else if year mod 100 <> 0 andalso year mod 4 = 0
  then true
  else false

(*fun reasonable_date (date : int*int*int) = 
  if (#1 date) < 1 
  orelse (#2 date) > 12 
  orelse (#2 date) < 1 
  orelse (#3 date) < 1
  then false
  else
    let
      val numOfDayInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] 
    in
      if (#3 date) <= List.nth(numOfDayInMonth, (#2 date) - 1)
      then true 
      else if (#2 date) = 2 
              andalso isLeapYear(#1 date)
              andalso (#3 date) <= List.nth(numOfDayInMonth, (#2 date) - 1) + 1
      then true
      else false
    end*)

(*better solution*)
fun reasonable_date (date : int*int*int) = 
  if (#1 date) < 1 
  orelse (#2 date) > 12 
  orelse (#2 date) < 1 
  orelse (#3 date) < 1
  then false
  else
    let
      val numOfDayInFeb = if isLeapYear(#1 date) then 29 else 28
      val numOfDayInMonth = [31, numOfDayInFeb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] 
    in
      if (#3 date) <= List.nth(numOfDayInMonth, (#2 date) - 1)
      then true 
      else false
    end
    

