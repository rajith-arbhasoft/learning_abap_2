*selection screen
PARAMETERS: p_matnr TYPE matnr.
*syntax :SELECT * FROM <DB_TABLE> INTO TABLE <ITAB> WHERE F1 = V1 AND/OR F2=V2.
*@- hosting vairbale
SELECT DISTINCT *
  FROM mara
  INTO TABLE @DATA(gt_mara) WHERE matnr = @p_matnr ORDER BY matnr.

LOOP AT gt_mara INTO DATA(gs_mara).
  WRITE: / gs_mara-matnr,' ',gs_mara-ernam.
ENDLOOP.


* selecting specific fields

TYPES: BEGIN OF gty_mara,
         matnr TYPE mara-matnr,
         ernam TYPE mara-ernam,
       END OF gty_mara.

DATA:gt_mara TYPE STANDARD TABLE OF gty_mara,
     gs_mara TYPE gty_mara.

SELECT matnr,ernam
  FROM mara
  INTO TABLE @gt_mara up to 5 ROWS.

LOOP AT gt_mara INTO gs_mara.
  WRITE: / gs_mara-matnr,' ',gs_mara-ernam.
ENDLOOP.



*&---------------------------------------------------------------------*
*& Report ZDEMO_DAY_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo_day_6.

* selecting specific fields

TYPES: BEGIN OF gty_mara,
         matnr TYPE mara-matnr,
         ernam TYPE mara-ernam,
       END OF gty_mara.

DATA:gt_mara TYPE STANDARD TABLE OF gty_mara,
     gs_mara TYPE gty_mara.

SELECT matnr,ernam
  FROM mara
  INTO TABLE @gt_mara up to 5 ROWS.

LOOP AT gt_mara INTO gs_mara.
*  WRITE: / gs_mara-matnr,' ',gs_mara-ernam.
ENDLOOP.

  

data wa_ type gty_mara.
SELECT SINGLE matnr,ernam FROM mara INTO CORRESPONDING FIELDS OF @wa_.

 write:/ wa_-ernam,' ',wa_-matnr.
 
* conversion exit moduel to convert one type to another
 
 
 