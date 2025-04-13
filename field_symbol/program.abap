*&---------------------------------------------------------------------*
*& Report ZOTESTR_LOOP_AT_ASSIGING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOTESTR_LOOP_AT_ASSIGING.


types: tab_string type string.

data: lt_string type STANDARD TABLE OF tab_string.

append 'rajith' to lt_string.
append 'zajith' to lt_string.
append 'kajith' to lt_string.
append 'majith' to lt_string.


FIELD-SYMBOLS: <fs_str> type string. " int *ptr declaration of pointer

ASSIGN lt_string[ 1 ] to <fs_str>. " assinging address

write:'first element ', <fs_str>. "accessing value"
write:''.
write:'second element', <fs_str>+1.
write:''.
write:'third element', <fs_str>+2.
write:''.
write:'third element', <fs_str>+3.
write:''.
write:'third element', <fs_str>+4.
write:''.
write:'third element', <fs_str>+5.

*program 2

FIELD-SYMBOLS: <fs_strstr> type string.

loop at lt_string ASSIGNING <fs_strstr>.

    write:<fs_strstr>.
    NEW-LINE.

ENDLOOP.
