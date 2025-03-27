*&---------------------------------------------------------------------*
*& Report Z_DEMO_INTERNAL_TABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_internal_table.

"internal table holds more than one row at runtime
"1.standard IT"
"2.sorted IT"
"3. Hashed IT"

"DATA: gt_<des> TYPE STANDARD TABLE OF (ANY TABLE)"
"THERE ARE TWO WAY WE CAN MANIPULATE THE INTERNAL TABLE "
"1 open sql -> to manipulate the internal table"
"2 native sql -> to manipulate the custom database table"


"open sql"

"insert->  INSERT wa to itable INDEX <row number>"
"update->  MODIFY itable from wa INDEX <row number>"
"delete-> "
"1.we can delete using work area  ->DELETE TABLE  itable FROM wa "
"2. using with where clause -> DELETE itable where condition"
"3. delete the adjusemnt records ->  "


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
    ( st_id = 3 st_result = 'X' st_fee = 4000 st_name = 'Ramesh' st_age = 10 )
    ( st_id = 4 st_result = 'X' st_fee = 4000 st_name = 'Ramesh' st_age = 10 )
    ( st_id = 5 st_result = 'X' st_fee = 4000 st_name = 'Ramesh' st_age = 10 )
).



"getting row by row data from the internal table"
LOOP AT gt_zstdstd into gs_zstdstd.
  WRITE: / gs_zstdstd-st_id,' ',gs_zstdstd-st_name.
ENDLOOP.