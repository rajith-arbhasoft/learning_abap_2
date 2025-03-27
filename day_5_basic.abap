*&---------------------------------------------------------------------*
*& Report Z_DEMO_DAY_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_day_5.

*types of internal table

*standard internal tables -> 99% in this type of we can add how ever we want and where ever we want
*  syntax : DATA gt <DES> TYPE  STANDARD TABLE OF gty_desc

* sorted internal table -> we have to provide the sorted key while the data we have to send in the form of sorted key
*  syntax: DATA gt_<desc> TYPE SORTED TABLE OF gty_desc NON-UNIQUE KEY  <F1> <F2>.

* Hashed internal tables -> Hased algo to update the data
*  syntax:  DATA gt_<desc> TYPE HASHED TABLE OF gty_<desc>.

* how to add the data into this internal table: 2 types of sql syntax
* 1.open sql-> used to add the data into the internal table
*       Append-> APPEND wa To intb (adds the new redord at the back)
*       Insert-> INSERT wa INTO itab INDEX <ROW ID>.(insert means add the new record with specified row position if you didnlt specify row number it will act as append)
*       Modify-> MODIFY itab FROM wa INDEX <ROW ID>.
*       Delete->
*           delete based on condition
*                 DELETE gt_<desc> where f1 [condiotanl operator] valu1.
*            delete with work area(used inside the loop)
*             DELETE TABLE itab from wa
*            deleting  adjuscent duplicates-> If u want to fetch unique records by deleting the duplicate records ,inorder apply the table should be sorted based on condiotn which we want to delete



* 2. Native sql-> use to add the data inot the standard table
* mainly these document related to open sql

TYPES: BEGIN OF gty_zstdstd,
         st_id     TYPE zstdstd-st_id,
         st_result TYPE zstdstd-st_result,
         st_fee    TYPE zstdstd-st_fee,
         st_name   TYPE zstdstd-st_name,
         st_age    TYPE zstdstd-st_age,
       END OF gty_zstdstd.


"WORK AREA AND INTERNAL TABLE"
DATA: gs_zstdstd TYPE gty_zstdstd,
      gt_zstdstd TYPE STANDARD TABLE OF gty_zstdstd.


"MAIN LOGIC"
"MOVE THE DATA FROM THE TABLE TO WORK AREA INORDER TO POPULATE TO INTERNAL TABLE"
gs_zstdstd = VALUE #( st_id = 1
                     st_result = 'X'
                     st_fee = 4000
                     st_name = 'Ramesh'
                     st_age = 10 ).
"also u don not need work area directly you can append value to the internal table"
APPEND gs_zstdstd TO gt_zstdstd. "#record-1 "

APPEND VALUE #(
 st_id = 2
 st_result = 'X'
 st_fee = 3000
 st_name = 'kuthrapalli'
  st_age = 13
) TO gt_zstdstd.


"we can add multiple data using value"

gt_zstdstd = VALUE #(
    ( st_id = 1  st_result = 'X'  st_fee = 3500  st_name = 'Ramesh'  st_age = 18 )
    ( st_id = 2  st_result = ' '  st_fee = 4200  st_name = 'Suresh'  st_age = 20 )
    ( st_id = 3  st_result = 'X'  st_fee = 2800  st_name = 'Mahesh'  st_age = 15 )
    ( st_id = 4  st_result = ' '  st_fee = 5000  st_name = 'Ganesh'  st_age = 22 )
    ( st_id = 5  st_result = 'X'  st_fee = 3900  st_name = 'Rajesh'  st_age = 17 )
    ( st_id = 6  st_result = ' '  st_fee = 4500  st_name = 'Lokesh'  st_age = 21 )
    ( st_id = 7  st_result = 'X'  st_fee = 3100  st_name = 'Dinesh'  st_age = 19 )
    ( st_id = 8  st_result = ' '  st_fee = 3300  st_name = 'Mukesh'  st_age = 16 )
    ( st_id = 9  st_result = 'X'  st_fee = 3700  st_name = 'Harish'  st_age = 23 )
    ( st_id = 10 st_result = ' '  st_fee = 4100  st_name = 'Naresh'  st_age = 14 )
).

SKIP.
"getting row by row data from the internal table"
LOOP AT gt_zstdstd INTO gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name.
ENDLOOP.
SKIP.
*type - 1 using condition statement
DELETE gt_zstdstd WHERE st_id = 3.

LOOP AT gt_zstdstd INTO gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name.
ENDLOOP.
SKIP.
* type - 2 using wa
LOOP AT gt_zstdstd INTO gs_zstdstd.
  IF gs_zstdstd-st_age = 10.
    DELETE TABLE gt_zstdstd FROM gs_zstdstd.
  ENDIF.
ENDLOOP.
SKIP.
LOOP AT gt_zstdstd INTO gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name.
ENDLOOP.
SKIP.
*sort statments: this will sort internal table is ordered ascending or descending (by default asc)

*sytanx: SORT gt_<desc> by f1 f2 f3.
*       SORT gt_<desc> by f1 f2 f3 descending.

SORT gt_zstdstd BY st_age.
LOOP AT gt_zstdstd INTO gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name.
ENDLOOP.
*group by statments

*type 3 deletion
SORT gt_zstdstd BY st_age. "its manditory"
DELETE ADJACENT DUPLICATES FROM gt_zstdstd COMPARING st_age. "also coparing also manditory"
WRITE 'getting unique value of age'.
SKIP.
LOOP AT gt_zstdstd INTO gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name,' ',gs_zstdstd-st_age.
ENDLOOP.

*Read statment
*SY-SUBRC -> IT WILL TELLS THE  STATEMTN SUCCESS OR FAIL (0 - SUCCESS ,OTHER THAN 0 IT MEANS FAILURE)
*select quaries, read statment, native sql stament,if the connection to the 3rd party system is successful or not

*read statment
*READ TABLE gt_<desc> into WA with key f1=v1 f2=v2 f3=v3    ->will return first record which satisfy the conditon

* optimized read statment
* READ WITH BINARY SEARCH
*READ TABLE gt_<desc> into WA with key f1=v1 f2=v2 f3=v3 BINARY SEARCH.
skip.
data lw_test type gty_zstdstd.
SORT gt_zstdstd by st_id.
READ TABLE gt_zstdstd into lw_test with key st_id = 8 BINARY SEARCH.

write: 'read statment result ',lw_test-st_id,lw_test-st_name.