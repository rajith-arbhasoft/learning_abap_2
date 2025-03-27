class cls_exmp DEFINITION.
  public SECTION.
  methods: display_message.
ENDCLASS.
  
class cls_exmp IMPLEMENTATION.
  method display_message.
     write:/ 'hello classes'.
  ENDMETHOD.
endclass.
START-OF-SELECTION. "helps to seperate the declaration and main logic"
data: obj type ref to cls_exmp.
obj = NEW cls_exmp( ).
obj->display_message( ).