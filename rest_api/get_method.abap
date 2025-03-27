*&---------------------------------------------------------------------*
*& Report zotestr_rest_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zotestr_rest_1.


data:lv_url type string value 'https://jsonplaceholder.typicode.com/users'.

*step 1: create an http client object

cl_http_client=>create_by_url(
  EXPORTING
    url                        = lv_url
*    proxy_host                 =
*    proxy_service              =
*    ssl_id                     =
*    sap_username               =
*    sap_client                 =
*    proxy_user                 =
*    proxy_passwd               =
*    do_not_use_client_cert     = abap_false
*    use_scc                    = abap_false
*    scc_location_id            =
*    oauth_profile              =
*    oauth_config               =
  IMPORTING
    client                     = data(lo_client)
*  EXCEPTIONS
*    argument_not_found         = 1
*    plugin_not_active          = 2
*    internal_error             = 3
*    pse_not_found              = 4
*    pse_not_distrib            = 5
*    pse_errors                 = 6
*    oa2c_set_token_error       = 7
*    oa2c_missing_authorization = 8
*    oa2c_invalid_config        = 9
*    oa2c_invalid_parameters    = 10
*    oa2c_invalid_scope         = 11
*    oa2c_invalid_grant         = 12
*    others                     = 13
).
IF SY-SUBRC = 0.
"step2 make a request
lo_client->send(
*  EXPORTING
*    timeout                    = co_timeout_default
*  EXCEPTIONS
*    http_communication_failure = 1
*    http_invalid_state         = 2
*    http_processing_failed     = 3
*    http_invalid_timeout       = 4
*    others                     = 5
).
IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
"step4 recieve the response
lo_client->receive(
*  EXCEPTIONS
*    http_communication_failure = 1
*    http_invalid_state         = 2
*    http_processing_failed     = 3
*    others                     = 4
).
IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
"step get the data
data(result) = lo_client->response->get_cdata( ).

cl_abap_browser=>show_html(
  EXPORTING
*    html         = 'value'
    title        = 'hello'
*    size         = cl_abap_browser=>medium
*    modal        = abap_true
    html_string  = result
*    printing     = abap_false
*    buttons      = navigate_off
*    format       = cl_abap_browser=>landscape
*    position     = cl_abap_browser=>topleft
*    data_table   =
*    anchor       =
*    context_menu = abap_false
*    html_xstring =
*    check_html   = abap_true
*    container    =
*    dialog       = abap_true
*  IMPORTING
*    html_errors  =
).

ENDIF.