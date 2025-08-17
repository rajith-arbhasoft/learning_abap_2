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

    class-methods get_bal_qty for table function zotestr_cds_fun_tab.

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

  method get_bal_qty by database function for hdb language sqlscript options read-only
        using VBAK VBAP LIPS LIKP.
        DECLARE lv_client VARCHAR(3);
          
        itab1 = select
                vbak.mandt,
                vbap.vbeln,
                vbap.posnr,
                vbap.matnr,
                vbap.arktx,
                vbap.kwmeng
                from vbak as vbak inner join vbap as vbap on vbak.vbeln = vbap.vbeln LIMIT 100;

        itab2 = select lips.mandt,
                       lips.vgbel as vbeln,
                       lips.vgpos as posnr,
                       sum( lfimg ) as dlv_qty
                       from lips as lips inner join likp
                       on lips.mandt = likp.mandt
                       and lips.vbeln = likp.vbeln
                       inner join :itab1 on lips.mandt = :itab1.mandt
                                            and lips.vgbel = :itab1.vbeln
                                            and lips.vgpos = :itab1.posnr   

                       group by lips.mandt,
                                lips.vgbel,
                                lips.vgpos limit 100;

     return select :itab1.mandt ,
                    :itab1.vbeln,
                    :itab1.posnr,
                    :itab1.matnr,
                    :itab1.arktx,
                    :itab1.kwmeng as ord_qty,
                    :itab2.dlv_qty,
                    ( :itab1.kwmeng - :itab2.dlv_qty ) as bal_qty
                    from :itab1 left outer join :itab2
                    on :itab1.vbeln = :itab2.vbeln
                    and :itab1.posnr = :itab2.posnr limit 100;

  endmethod.



ENDCLASS.