*&---------------------------------------------------------------------*
*& Report Z_DEMO_DAY_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_day_3.

DATA(gv_add) = 100 + 200 + 3000.
DATA(gv_sub) = 1000 - 2000 - 500.
DATA(gv_mul) = 1000 * 2000 * 500.
DATA(gv_div) = 1000 / 2000 / 500.


*WRITE: gv_add,gv_sub,gv_mul,gv_div.




*syntax for if
* IF VAR1 = C1 OR/AND VAR2 = C2 .
*     abap logic
*ELSEIF  VAR3 = C3.
*     abapa logic
*ELSE."
*     abap logic
* ENDIF.


*syntax for switch

*CASE var.
*WHEN C1 or C2.
* ABAP logic
*WHEN C3 OR C4.
* ABAP logic
*OTHERS.
* ABAP logic
*ENDCASE.

PARAMETERS:p_opt   TYPE char1,
           p_opd_1 TYPE i,
           p_opd_2 TYPE i.

IF p_opd_1 < p_opd_2.
  WRITE 'operand-1 must be greater than operand operand-2'.
ENDIF.

IF p_opt <> '+' AND p_opt <> '-' AND p_opt <> '*' AND p_opt <> '/' .
  LEAVE PROGRAM.
ENDIF.

DATA lv_result TYPE i.
CASE p_opt.
  WHEN '+'.
    lv_result = p_opd_1 + p_opd_2.
  WHEN '-'.
    lv_result = p_opd_1 - p_opd_2.
  WHEN '/'.
    lv_result = p_opd_1 / p_opd_2.
  WHEN '*'.
    lv_result = p_opd_1 * p_opd_2.
ENDCASE.

WRITE: 'result : ',lv_result.

WRITE 'programe completed... !'.


* new  syntax for if
*# used to tell the generic data type also u can replace with data type if u know the data type
DATA lv_test_user TYPE char10 VALUE 'ramesh'.

DATA(lv_user_role) = COND #( WHEN lv_test_user = 'ramesh' THEN 'Manager'
                             WHEN lv_test_user = 'rajith' THEN 'Owner'
                             WHEN lv_test_user = 'majith' THEN 'Driver'
                            ELSE 'invalid user'
                                ).

WRITE:'role of user using new if syntax',lv_user_role.

*new syntax for switch
WRITE:/ SWITCH char20( p_opt
                    WHEN '+' THEN  p_opd_1 + p_opd_2
                    WHEN '-' THEN  p_opd_1 + p_opd_2
                    WHEN '*' THEN  p_opd_1 + p_opd_2
                    WHEN '/' THEN  p_opd_1 + p_opd_2 ).