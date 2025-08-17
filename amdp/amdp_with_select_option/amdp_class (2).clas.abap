CLASS zotestr_amdp_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.

    types:BEGIN OF tp_order,
          vbeln type vbak-vbeln,
          erdat type vbak-erdat,
          kunnr type vbak-kunnr,
          vkorg type vbak-vkorg,
          posnr type vbap-posnr,
          matnr type vbap-matnr,
          arktx type vbap-arktx,
          kwmeng type vbap-kwmeng,
          vrkme type vbap-vrkme,
          netwr type vbap-netwr,
          end of tp_order.
    types: tt_order type STANDARD TABLE OF tp_order with empty key.

    types:tt_items type STANDARD TABLE OF bsid.

    methods get_fi_items
        importing
            value(lv_where) type string
         exporting
            value(et_all) type tt_items
            value(et_filter) type tt_items.

    methods get_order_details
        importing
            value(imp_mandt) type mandt
            value(imp_vbeln) type vbak-vbeln
         exporting
            value(exp_order) type tt_order.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zotestr_amdp_2 IMPLEMENTATION.
  METHOD get_order_details by DATABASE PROCEDURE FOR HDB LANGUAGE sqlscript options READ-ONLY using vbak vbap.

    exp_order = select vbak.vbeln,
                       vbak.erdat,
                       vbak.kunnr,
                       vbak.vkorg,
                       vbap.posnr,
                       vbap.matnr,
                       vbap.arktx,
                       vbap.kwmeng,
                       vbap.vrkme,
                       vbap.netwr
               from vbak as vbak inner join vbap as vbap
               on vbak.vbeln = vbap.vbeln
               where vbak.mandt = :imp_mandt
               and vbak.vbeln = :imp_vbeln;

  ENDMETHOD.

  METHOD get_fi_items by database PROCEDURE FOR HDB LANGUAGE SQLSCRIPT options READ-ONLY using bsid bsad.

        et_all = select * from bsid
            union all
            select * from bsad;

      et_filter = APPLY_FILTER ( :et_all, :lv_where);
  ENDMETHOD.

ENDCLASS.