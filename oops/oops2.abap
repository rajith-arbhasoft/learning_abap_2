*&---------------------------------------------------------------------*
*& Report Z_DEMO_OOPS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_oops.
CLASS cls_calculate DEFINITION.
  PUBLIC SECTION.
    METHODS: m_add
      IMPORTING lv_num1 TYPE i
                lv_num2 TYPE i
      EXPORTING lv_sum  TYPE i.

    METHODS:m_sub
      CHANGING lv_change_num1 TYPE i
               lv_change_num2 TYPE i.
   METHODS:m_greeting
      RETURNING VALUE(rt_message) type string.

ENDCLASS.

CLASS cls_calculate IMPLEMENTATION.
  METHOD m_add.
    lv_sum = lv_num1 + lv_num2.
  ENDMETHOD.

  METHOD m_sub.
    lv_change_num1 = lv_change_num1 - lv_change_num2.
  ENDMETHOD.

  method m_greeting.
    rt_message = 'Welcome to OOTY ! Nice to Meet You **'.
  endmethod.
ENDCLASS.

START-OF-SELECTION.

  DATA(obj) = NEW cls_calculate( ).
  DATA l_sum TYPE i.
  DATA chng_num1 TYPE i VALUE 30.
  DATA chng_num2 TYPE i VALUE 20.
  data rt_greeting_message type string.

  obj->m_add(
  EXPORTING lv_num1 = 10
            lv_num2 = 20
  IMPORTING lv_sum = l_sum
  ).

  obj->m_sub(
    CHANGING lv_change_num1 = chng_num1
              lv_change_num2 = chng_num2
  ).

rt_greeting_message = obj->m_greeting( ).
  WRITE:/ ' sum calculated ',l_sum.
  write:/ 'diff calculated ',chng_num1.
  write :/ 'greeing ',rt_greeting_message.