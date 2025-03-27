*&---------------------------------------------------------------------*
*& Report ZR1030AM_FIRST_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR1030AM_FIRST_PROGRAM.

"concatination-> is method of clubing two or more vairable to single variable or field"

" syntax: CONCATENATE <f1> <f2> <f3> ... into <Fval> ."

DATA: LV_NAME TYPE string VALUE 'RAMU',
      LV_AGE  TYPE char2 VALUE 12,
      LV_MARK TYPE char2 VALUE 20,
      LV_RESULT TYPE char1 VALUE 'X'.

TYPES: BEGIN OF TY_STD,
   NAME TYPE string ,
  AGE TYPE char2 ,
  MARK TYPE char2,
  RESULT TYPE CHAR1,
  END OF TY_STD.

DATA STDSTD TYPE TY_STD.

  STDSTD-NAME = LV_NAME.
  STDSTD-AGE = LV_AGE.
  STDSTD-MARK = LV_MARK.
  STDSTD-RESULT = LV_RESULT.

DATA LV_STUDENT TYPE string.

"clearing the value of structure"
"CLEAR: <STUR> <VAR>."

CLEAR: STDSTD.

CONCATENATE LV_NAME  LV_AGE LV_MARK LV_RESULT INTO LV_STUDENT.
"CONCATE is used to send data from sap to non sap ,third party system should be recongnize it"
WRITE LV_STUDENT.
"inorder to understand we should concate with seperator"
" syntax: CONCATENATE <f1> <f2> <f3> ... into <Fval> SEPERATED BY '<SEPERATOR>'."
SKIP.

CONCATENATE LV_NAME  LV_AGE LV_MARK LV_RESULT INTO LV_STUDENT SEPARATED BY ','.

WRITE LV_STUDENT.

"splitting the concatinated value if LV_STUDENT"
"SPLIT <var> AT <SEPERATOR> inot <v1> <V2> ...  ."
SKIP.

SPLIT LV_STUDENT AT ',' into STDSTD-NAME STDSTD-AGE STDSTD-MARK STDSTD-RESULT.

WRITE: 'AFTER CONCATING AND SPLITTING PROCESS',/ STDSTD-NAME.



"NEW SYNTAX  OF CONCATINATION"

DATA STDINONEGO TYPE string.

STDINONEGO = |{ STDSTD-NAME }&{ STDSTD-AGE }&{ STDSTD-MARK }|.

SKIP.

WRITE: 'NEW SYTANX OF CONCATINATION',STDINONEGO.
