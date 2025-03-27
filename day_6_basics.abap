*&---------------------------------------------------------------------*
*& Report ZDEMO_DAY_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo_day_6.

*select statment
* 1.select *
*   a.n numbers of rows
*   b. where condition
*   c.get entire data
*2. select required fields
*   a.get entire data
*   b.n number of rows
*   c.based on where condition
*3. SELECT SIGNAL VS SELECT UP TO 1 ROWS
*4. get the data from multiple tables
*   a.joins ->mainly used with h4/hana
*   b. for all entries ->mainly used with ECC system


*---------select statment-------------
* syntax: select * from <db_table> into table <ITAB>.

DATA: gt_mara TYPE STANDARD TABLE OF mara.

SELECT * FROM mara INTO TABLE gt_mara.
* SELECT * FROM mara INTO TABLE @DATA(gt_mara). by this syntax we can eliminate the extra declaration of dta type of gloabl table

IF sy-subrc = 0.
  SORT gt_mara BY matnr.
  DELETE ADJACENT DUPLICATES FROM gt_mara COMPARING matnr.
ENDIF.

* display the data

LOOP AT gt_mara INTO DATA(gs_mara).
*   write:/ gs_mara-matnr.
ENDLOOP.

* syntax: select * from <db_table> into table <ITAB> up to n rows.

SELECT * FROM mara INTO TABLE gt_mara UP TO 10 ROWS.
IF sy-subrc = 0.
  SORT gt_mara BY matnr.
  DELETE ADJACENT DUPLICATES FROM gt_mara COMPARING matnr.
ENDIF.

LOOP AT gt_mara INTO DATA(gs_mara2).
*  WRITE:/ gs_mara2-matnr.
ENDLOOP.

*syntax :SELECT * FROM <DB_TABLE> INTO TABLE <ITAB> WHERE F1 = V1 AND/OR F2=V2.
SELECT DISTINCT *
  FROM mara
  INTO TABLE @data(gt_mara) WHERE matnr = '000000000000000015' ORDER BY matnr.

LOOP AT gt_mara INTO DATA(gs_mara).
  WRITE: / gs_mara-matnr,' ',gs_mara-ernam.
ENDLOOP.