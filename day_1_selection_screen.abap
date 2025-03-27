*&---------------------------------------------------------------------*
*& Report ZDEM_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEM_SELECTION_SCREEN.

TABLES:ZSTDSTD."it is used to import the database table in selection screen"

"create a block"
"text-001 : contain the title ,we can give hard coded text ,parameterize code"
SELECTION-SCREEN  BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  "parameter for single input's "
  "obligatory for manditory"
  "goto -> text element"
  PARAMETERS: p_name TYPE string OBLIGATORY DEFAULT 'student Name',
              p_chk as CHECKBOX DEFAULT 'X'.

  SELECTION-SCREEN SKIP.
  PARAMETERS:p_rb1 RADIOBUTTON GROUP rb,
            p_rb2 RADIOBUTTON GROUP rb DEFAULT 'X',
            p_rb3 RADIOBUTTON GROUP rb.

  SELECT-OPTIONS:st_id FOR ZSTDSTD-st_id.
  "if u want to make drop down we hage "
SELECTION-SCREEN END OF BLOCK b1 .

START-OF-SELECTION. "its an event occurs after the selection screen  "
IF p_chk = 'X'.
  WRITE :/ text-002.
ELSE.
  WRITE :/ text-003.
ENDIF.