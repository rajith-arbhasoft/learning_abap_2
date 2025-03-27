*&---------------------------------------------------------------------*
*& Report ZDEMO_DAY_7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo_day_7.
*selection screen

* parameter->used to pass single values
*       inputBox
*       checkBox
*       RadioButton

* select options -> provides mupltiple values
* a. when we create a select options sap will create a ITAB with header line
* fields available inside the itab
*     1.SIGN -> I- INCLUDE AND E-EXCLUDE THE VALUES
*     2.OPTIONS -> EQ,GT,LT,GE,LE,BT,NE..
*     3.LOW ->

*     4.HIGH

* b. Internal table wiht header line

* i. The same declaration will be used for both wa as well as itab (old syntax)
TYPES: BEGIN OF gty_mara,
         matnr           TYPE mara-matnr,
         created_at_time TYPE mara-created_at_time,
         pstat           TYPE mara-pstat,
         mtart           TYPE mara-mtart,
         mbrsh           TYPE mara-mbrsh,
       END OF gty_mara.

*header line will create internal table and work area
DATA:gt_mara TYPE STANDARD TABLE OF gty_mara WITH HEADER LINE.

* gt_mar[].-> to access internal table
* gt_mar -> to access work area

*SELECT DISTINCT matnr,created_at_time,pstat,mtart,mtart FROM mara INTO TABLE @gt_mara[] UP TO 10 ROWS ORDER BY created_at_time,matnr.


LOOP AT gt_mara.
  WRITE:/ gt_mara-matnr,' ',gt_mara-created_at_time,' ',gt_mara-mbrsh.
ENDLOOP.


* select statement
*syntax: SELECT-OPTIONS: S_<DESC> FOR <DBTABLE-FIELD NAME>

*first method: declare table syntax and will write select-option

TABLES: mara.

SELECT-OPTIONS: s_mtart FOR mara-mtart.

*second method: predeifined type //recommoneded way
* bcz the first method the entire table schema will be inside the memory of the abap
DATA: gv_var TYPE char10.

SELECT-OPTIONS: s_var FOR gv_var.

* how to pass select option to selection query

SELECT mtart FROM mara INTO TABLE @DATA(Zgt_mar_mara) where mtart in @s_var[].

loop at zgt_mar_mara into data(zgs_mar_mara).
   WRITE:/ zgs_mar_mara-mtart.
ENDLOOP.

*SELECT-OPTIONS IF YOU DIDN'T GIVE ANY VALUE THEN IT WILL SHOW EVERY VALUE IN TABLE
*IN PARAMETER IT WONT EXECUTE
* IF USER HAVE A REQUIRMENT THAT THE SHOULD SHOW ALL VALUE BUT ONLY SHOW FROM VALUE DO NOT SHOW EXTENSION AND TO

SELECT-OPTIONS: s_mtartT FOR mara-mtart NO INTERVALS NO-EXTENSION.
* check this "Selection screen design - Select options" last portion to use search help and the parameter to get the same feature of selection-options ,which selection-option can pass empty to get all the data