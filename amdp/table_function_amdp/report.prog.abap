REPORT zotestr_amdp_demo_1.

select * from zotestr_cds_fun_tab into table @data(gt_so).

cl_demo_output=>display( gt_so ).