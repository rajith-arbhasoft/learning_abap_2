*&---------------------------------------------------------------------*
*& Report zotestr_amdp_demo_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zotestr_amdp_demo_1.
tables: bsid.

PARAMETERS:p_vbeln type vbak-vbeln.

SELECT-OPTIONS:s_burks for bsid-bukrs.
SELECT-OPTIONS:s_belnr for bsid-belnr.
select-options:s_gjahr for bsid-gjahr.
select-options:s_kunnr for bsid-kunnr.


START-OF-SELECTION.
try.

data(lv_where) = cl_shdb_seltab=>combine_seltabs(
                   it_named_seltabs = value #(
                    ( NAME = 'BUKRS' DREF = REF #( S_BURKS[] ) )
                    ( NAME = 'BELNR' DREF = REF #( S_BELNR[] ) )
                    ( NAME = 'GJAHR' DREF = REF #( S_GJAHR[] ) )
                    ( NAME = 'KUNNR' DREF = REF #( S_KUNNR[] ) )
                   )

                   iv_client_field  = 'MANDT'
                 ).
                 CATCH cx_shdb_exception.
                 ENDTRY.

    "perform call_amdp.
    data(lr_new) = new zotestr_amdp_2( ).

    lr_new->get_fi_items(
      EXPORTING
        lv_where  = lv_where
      IMPORTING
        et_all    = data(gt_all)
        et_filter = data(gt_filter)
    ).

    try.
call method cl_salv_table=>factory
*  EXPORTING
*    list_display   = if_salv_c_bool_sap=>false
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   = data(lr_salv)
  CHANGING
    t_table        = gt_filter
  .
*CATCH cx_salv_msg.
    catch cx_root.
endtry.

lr_salv->display(  ).



end-OF-SELECTION.