*&---------------------------------------------------------------------*
*& Report Z_DEMO_DAY_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DEMO_DAY_4.

*global--> when we declare varibales in main program at the top  or int the top include
* GV_<DEC>
*local --> when declare in the sub program include program / sub routine / class module/
*LV_<DEC>

*NEW SYNTAXS
*INLINE DATA DECLARATION

data(gv_var1) = 'hello kuttichatha'.
skip.
write gv_var1.
skip.
gv_var1 = 'djfidjfidifjdifdfjidjfdjfidjfdj'. "assinging long value from initalized value"
skip.
write gv_var1. 
* so the gv_var1 will have length of initlized value if we are trying to assing more than that varibale will trim the value 

*--------------------------------------------------*
*-------------selection secreen--------------------*
* we can create selection screen using two type
* using parameter ->pass single value
* using select option ->we can pass range of value