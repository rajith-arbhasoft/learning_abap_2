*1. Employee Salary Checker
*Task:
*Write an ABAP program that stores employee names and salaries in an internal table. The program *should display employees earning more than a specified amount.
*Steps to Solve:
*Declare an internal table (itab_emp) with fields name and salary.
*Populate the table with some sample employee data.
*Use a LOOP AT statement to iterate through the internal table.
*Use an IF condition to check if the salary is above a given threshold.
*Display employees who meet the condition using WRITE.
*Implement the logic inside a method for reusability.



  REPORT zempchecker.


*  declare a structure
  TYPES:BEGIN OF ty_itab_values,
          emp_id     TYPE char2,
          emp_name   TYPE string,
          emp_age    TYPE i,
          emp_salary TYPE i,
        END OF ty_itab_values.
*  creating a 2 internal table and one work area
  DATA: itab_values        TYPE STANDARD TABLE OF ty_itab_values,
        itab_values_unique TYPE STANDARD TABLE OF ty_itab_values,
        g_wa               TYPE ty_itab_values,
        temp_wa            TYPE ty_itab_values.

  DATA salary_thrushold TYPE i VALUE 1000.
  .


*  append data with duplicate values

  itab_values = VALUE #(
  ( emp_id = 1  emp_name = 'rajesh'  emp_age = 12  emp_salary = 2000 )
  ( emp_id = 1  emp_name = 'rajesh'  emp_age = 12  emp_salary = 2000 )
  ( emp_id = 2  emp_name = 'ramesh'  emp_age = 32  emp_salary = 100 )
  ).

*  remove the duplicate value
  LOOP AT itab_values INTO g_wa.
    READ TABLE itab_values_unique INTO temp_wa WITH KEY emp_id = g_wa-emp_id emp_name = g_wa-emp_name emp_age = g_wa-emp_age emp_salary = g_wa-emp_salary.
    IF ( sy-subrc <> 0 ).
      APPEND g_wa TO itab_values_unique.
    ENDIF.
  ENDLOOP.
*  create second internal table

  LOOP AT itab_values_unique INTO g_wa.
    IF g_wa-emp_salary >= salary_thrushold.
      WRITE:/ g_wa-emp_id ,' ',g_wa-emp_name ,' ',g_wa-emp_age ,' ',g_wa-emp_salary .
    ENDIF.
  ENDLOOP.
