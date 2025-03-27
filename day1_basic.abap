*&---------------------------------------------------------------------*
*& Report ZDEM_HELLO_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEM_HELLO_PROGRAM.

DATA name TYPE string.
DATA age(2) TYPE c.

DATA: hello TYPE i, ": allows chaining expression"
      new TYPE string,
      today TYPE d. "by default it is stored as =>  yyyymmdd  but output will like dd.mm.yyyy"

name = 'hello world'.   "this is hello wrold text"

today = sy-datum. "sy- gives system variable"

WRITE:/ today. "/means new line"

WRITE:/ 'My name is ',name,/'today is ',today .

TYPES: LOC_DEC TYPE i. "Its another type of variable declaration "

DATA: operand1 TYPE loc_dec VALUE 8,
      operand2 TYPE loc_dec VALUE 4,
      result  TYPE i.

result = operand1 + operand2.
WRITE:/'result of summation : ',result.

result = operand1 / operand2.
WRITE:/'result of division : ',result.

result = operand1 mod operand2.
WRITE:/'result of mod : ',result.


"--- structure with local data type ---- "

TYPES: BEGIN OF ty_person,
  name(23) TYPE c,
  age TYPE i,
  country(10) TYPE c,
  planet type string,
END OF ty_person.
"constant declaration"
CONSTANTS: lc_planet type string value 'Earth'.

"create an work area(single row of data)"
DATA: wa_person TYPE  ty_person.
wa_person-name = 'rajith'.
wa_person-age = 10.
wa_person-country = 'india'.
wa_person-planet = lc_planet.

WRITE:/ 'Name: ',wa_person-name,
/'Age: ',wa_person-age,
/'Country: ',wa_person-country,
/'planet: ',wa_person-planet.

"we can create  work area for database table"
DATA: wa_std type zstdstd.
SELECT SINGLE * FROM zstdstd INTO CORRESPONDING FIELDS OF wa_std.

write:/'selected from the database',
      /'student id: ',wa_std-st_id,
      /'student name: ',wa_std-st_name,
      /'student age: ', wa_std-st_age.