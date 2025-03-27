*constuctor
CLASS zcls_sum DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_num1 TYPE i
                            iv_num2 TYPE i,
      display_info.

  PRIVATE SECTION.
    DATA: mv_num1 TYPE i,
          mv_num2 TYPE i,
          mv_sum  TYPE i.
ENDCLASS.

CLASS zcls_sum IMPLEMENTATION.
  METHOD constructor.
    mv_num1 = iv_num1.
    mv_num2 = iv_num2.
  ENDMETHOD.

  METHOD display_info.
    mv_sum = mv_num1 + mv_num2.
    WRITE:/ 'sum of values', mv_sum.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(obj) = NEW zcls_sum( iv_num1 = 10 iv_num2 = 20 ).

  obj->display_info( ).


*static constructors,methods ,varibales 
CLASS zcls_sum DEFINITION.
  PUBLIC SECTION.
  class-data:lv_name type string.
  CLASS-METHODS:
  class_constructor,
  greeting.
ENDCLASS.

CLASS zcls_sum IMPLEMENTATION.
 method class_constructor.
   lv_name = 10.
 ENDMETHOD.
method greeting.
  write:/ 'hello my dear frend ',lv_name.
ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
zcls_sum=>greeting( ).


*inheritance with abstract method and its implementation
REPORT z_demo_oops.

*parent class defination
CLASS zcl_vehicle  DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING
                           iv_make  TYPE string
                           iv_model TYPE string,
      display_info,
      start ABSTRACT.
  PROTECTED SECTION.
    DATA:
      mv_make  TYPE string,
      mv_model TYPE string.
ENDCLASS.

*parent class implementation
CLASS zcl_vehicle IMPLEMENTATION.
  METHOD constructor.
    mv_make = iv_make.
    mv_model = iv_model.
  ENDMETHOD.
  METHOD display_info.
    WRITE:/ 'make ',mv_make.
    WRITE:/ 'model ',mv_model.
  ENDMETHOD.
ENDCLASS.

*child class defination

CLASS zcl_car DEFINITION INHERITING FROM zcl_vehicle.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_make  TYPE string
                            iv_model TYPE string
                            iv_doors TYPE i,
      display_info REDEFINITION,
      start REDEFINITION.
  PRIVATE SECTION.
    DATA:
          mv_doors TYPE i.
ENDCLASS.

*child implementation
CLASS zcl_car IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_make = iv_make iv_model = iv_model ).
    mv_doors = iv_doors.
  ENDMETHOD.

  METHOD start.
    WRITE:/ 'starting the code'.
  ENDMETHOD.

  METHOD display_info.
    super->display_info( ). "you cant access the varibale using super"
    WRITE:/ 'comes from child ',mv_doors.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(obj) = NEW zcl_car( iv_make ='mercedez'
                            iv_model = 'amg'
                             iv_doors = 4 ).

  obj->start( ).
  obj->display_info( ).



*Example for polymorphism
CLASS zcls_area DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: calculate_area ABSTRACT RETURNING VALUE(result) TYPE Decfloat16 ,
      display_result.
ENDCLASS.


CLASS zcls_area IMPLEMENTATION.
  METHOD display_result.
    DATA(lv_data) = me->calculate_area( ).
    WRITE:/ 'area ',lv_data DECIMALS 2.
  ENDMETHOD.
ENDCLASS.

CLASS zcls_circle DEFINITION INHERITING FROM zcls_area.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING
                           iv_radius TYPE f,
      calculate_area REDEFINITION.
  PRIVATE SECTION.
    DATA:lv_radius TYPE f.
    CONSTANTS: pi TYPE f VALUE '3.14' .
ENDCLASS.

CLASS zcls_circle IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    lv_radius = iv_radius.
  ENDMETHOD.

  METHOD calculate_area.
    result = lv_radius * lv_radius * pi.
  ENDMETHOD.
ENDCLASS.

CLASS zcls_rectangle DEFINITION INHERITING FROM zcls_area.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING
                           iv_height TYPE f
                           iv_width  TYPE f,
      calculate_area REDEFINITION.
  PRIVATE SECTION.
    DATA:lv_height TYPE f,
         lv_width  TYPE f.
ENDCLASS.

CLASS zcls_rectangle IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    lv_height = iv_height.
    lv_width = iv_width.
  ENDMETHOD.

  METHOD calculate_area.
    result = lv_height * lv_width.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: obj TYPE REF TO zcls_area.
  obj = NEW zcls_circle( iv_radius = 10 ).
  WRITE :/ '------------- circle --------------'.
  obj->calculate_area( ).
  obj->display_result( ).
  WRITE :/ '------------- Reactangle --------------'.
  obj = NEW zcls_rectangle( iv_width = 20 iv_height = 24 ).
  obj->calculate_area( ).
  obj->display_result( ).



*interface example
REPORT z_demo_oops.

*interface

INTERFACE g_int.
  methods :
    log_message IMPORTING iv_message type string.
  ENDINTERFACE.

interface g_int_2.
  methods:
      show_details.
ENDINTERFACE.

class zcl_car DEFINITION.
  PUBLIC SECTION.
    INTERFACEs: g_int,
                g_int_2.
ENDCLASS.


class zcl_car IMPLEMENTATION.
  method g_int~log_message.
    write:/'this is inherited fro the g_int interface'.
    write:/ iv_message.
  ENDMETHOD.

  method g_int_2~show_details.
    write:/'details '.
  ENDMETHOD.

ENDCLASS.
START-OF-SELECTION.
data(obj) =  new zcl_car( ).

obj->g_int~log_message( 'hello to world' ).
obj->g_int_2~show_details( ).
