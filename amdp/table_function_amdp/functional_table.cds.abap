@EndUserText.label: 'learning cds functional table for amdp'
define table function zotestr_cds_fun_tab
returns {
  mandt : abap.clnt;
  vbeln : vbeln_va;
  posnr : posnr_va;
  matnr : matnr;
  arktx : arktx;
  ord_qty : wmeng;
  dlv_qty : wmeng;
  bal_qty : wmeng;
}
implemented by method zotestr_amdp_2=>get_bal_qty;