(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your
* code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use
* "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val
* test1 = true : bool *)

use "cal.sml";

val test1_0 = is_older ((1,2,3),(2,3,4)) = true
val test1_1 = is_older ((2,3,3),(2,3,4)) = true
val test1_2 = is_older ((3,3,3),(2,3,4)) = false 
val test1_3 = is_older ((3,4,5),(3,6,4)) = true 
val test1_4 = is_older ((3,7,9),(3,7,4)) = false 

val test2_0 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2_1 = number_in_month ([(2012,3,28),(2013,12,1), (2013,12,3),(2013,12,1)],12) = 3
val test2_2 = number_in_month ([(2012,4,28),(2013,12,1)],7) = 0

val test3_0 = number_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test3_1 = number_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,12]) = 4
val test3_2 = number_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[11]) = 0

val test4_0 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4_1 = dates_in_month ([(2012,3,28),(2013,12,1), (2013,12,3),(2013,12,1)],12) = [(2013,12,1), (2013,12,3),(2013,12,1)]
val test4_2 = dates_in_month ([(2012,4,28),(2013,12,1)],7) = []

val test5_0 = dates_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) =
[(2012,2,28),(2011,3,31),(2011,4,28)]
val test5_1 = dates_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,12]) =
[(2012,2,28),(2011,3,31),(2011,4,28), (2013,12,1)]
val test5_2 = dates_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[11]) = []

val test6_0 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 0) = ""
val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 6) = "you"
val test6_3 = get_nth (["hi", "there", "how", "are", "you"], 3) = "how"

val test7_0 = date_to_string (2013, 1, 2) = "January 2, 2013"
val test7_1 = date_to_string (2012, 2, 28) = "February 28, 2012"
val test7_2 = date_to_string (2012, 3, 21) = "March 21, 2012"
val test7_3 = date_to_string (2012, 4, 21) = "April 21, 2012"
val test7_4 = date_to_string (2012, 5, 21) = "May 21, 2012"
val test7_5 = date_to_string (2012, 6, 21) = "June 21, 2012"
val test7_6 = date_to_string (2012, 7, 21) = "July 21, 2012"
val test7_7 = date_to_string (2012, 8, 21) = "August 21, 2012"
val test7_8 = date_to_string (2012, 9, 21) = "September 21, 2012"
val test7_9 = date_to_string (2012, 10, 21) = "October 21, 2012"
val test7_10 = date_to_string (2012, 11, 21) = "November 21, 2012"
val test7_11 = date_to_string (2012, 12, 21) = "December 21, 2012"

val test8_0 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8_1 = number_before_reaching_sum (1, [1,2,3,4,5]) = 0
val test8_2 = number_before_reaching_sum (2, [1,2,3,4,5]) = 1
val test8_3 = number_before_reaching_sum (11, [1,2,3,4,5]) = 4
val test8_4 = number_before_reaching_sum (16, [1,2,3,4,5]) = 6

val test9_0 = what_month 70 = 3
val test9_1 = what_month 1 = 1
val test9_2 = what_month 365 = 12
val test9_3 = what_month 32 = 2
val test9_4 = what_month 59 = 2
val test9_5 = what_month 60 = 3

val test10_0 = month_range (31, 34) = [1,2,2,2]
val test10_1 = month_range (32, 32) = [2]
val test10_2 = month_range (70, 72) = [3,3,3]
val test10_3 = month_range (70, 55) = []

val test11_0 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test11_1 = oldest([]) = NONE
val test11_2 = oldest([(2003,2,28),(2011,3,31),(2011,4,28)]) = SOME (2003,2,28)
val test11_3 = oldest([(2003,2,28),(2003,2,21),(2011,4,28)]) = SOME (2003,2,21)

val test12_0 = number_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,3,3,4,4,5]) = 3

val test12_1 = number_in_months_challenge ([(2012,2,28),(2013,12,1)],[2,3,2]) = 1
val test12_2 = number_in_months_challenge ([(2012,3,28),(2013,12,1),(2013,12,3),(2013,12,1)],[12,12]) = 3
val test12_3 = number_in_months_challenge ([(2012,4,28),(2013,12,1)],[7]) = 0
val test12_4 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,12,12]) = 4

val test13 = dates_in_months_challenge 
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,2,3,3,4,7]) =
[(2012,2,28),(2011,3,31),(2011,4,28)]
val test13_1 = dates_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) =
[(2012,2,28),(2011,3,31),(2011,4,28)]
val test13_2 = dates_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,12,12]) =
[(2012,2,28),(2011,3,31),(2011,4,28), (2013,12,1)]
val test13_3 = dates_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[8,8,11]) = []

val test14_0= reasonable_date(0,1,2) = false
val test14_1= reasonable_date(1,13,2) = false
val test14_2= reasonable_date(1,12,0) = false
val test14_3= reasonable_date(1999,1,31) = true 
val test14_4= reasonable_date(1999,8,31) = true 
val test14_5= reasonable_date(1996,2,29) = true 
val test14_6= reasonable_date(1995,2,29) = false 
val test14_7= reasonable_date(1000,2,29) = false 
val test14_8= reasonable_date(2000,2,29) = true 
