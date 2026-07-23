CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS create_empty_log FOR TESTING RAISING cx_bali_runtime.
    METHODS get_log_handle FOR TESTING RAISING cx_bali_runtime.
    METHODS save_log_2nd_connection FOR TESTING RAISING cx_bali_runtime.
    METHODS set_log_header FOR TESTING RAISING cx_bali_runtime.
    METHODS create_message FOR TESTING.
    METHODS create_message_from_bapiret2 FOR TESTING.
    METHODS test1 FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD create_empty_log.
    DATA object TYPE cl_bali_header_setter=>ty_object.
    DATA subobject TYPE cl_bali_header_setter=>ty_subobject.
    DATA external_id TYPE cl_bali_header_setter=>ty_external_id.
    DATA(log) = cl_bali_log=>create( ).

    cl_abap_unit_assert=>assert_initial( object ).
    cl_abap_unit_assert=>assert_initial( subobject ).
    cl_abap_unit_assert=>assert_initial( external_id ).
    cl_abap_unit_assert=>assert_bound( log ).
    cl_abap_unit_assert=>assert_initial( log->get_all_items( ) ).
  ENDMETHOD.

  METHOD get_log_handle.
    DATA(log) = cl_bali_log=>create( ).
    DATA(handle) = log->get_handle( ).

    cl_abap_unit_assert=>assert_not_initial( handle ).
    cl_abap_unit_assert=>assert_equals( act = log->get_handle( ) exp = handle ).
  ENDMETHOD.

  METHOD save_log_2nd_connection.
    DATA(log) = cl_bali_log=>create( ).

    cl_bali_log_db=>get_instance( )->save_log(
      log = log
      use_2nd_db_connection = abap_true ).
  ENDMETHOD.

  METHOD set_log_header.
    DATA(log) = cl_bali_log=>create( ).
    DATA(header) = cl_bali_header_setter=>create( object = 'ZFOOBAR' ).

    log->set_header( header ).
  ENDMETHOD.

  METHOD create_message.
    DATA detail_level TYPE if_bali_item_setter=>ty_detail_level.
    DATA severity TYPE if_bali_item_setter=>ty_severity.
    DATA id TYPE if_bali_message_setter=>ty_id.
    DATA number TYPE if_bali_message_setter=>ty_number.
    DATA variable_1 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_2 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_3 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_4 TYPE if_bali_message_setter=>ty_variable.

    DATA(message) = cl_bali_message_setter=>create(
      severity = if_bali_constants=>c_severity_warning
      id = '00'
      number = '001'
      variable_1 = 'first' ).

    message->set_detail_level( '7' )->get_all_values(
      IMPORTING
        detail_level = detail_level
        severity = severity
        id = id
        number = number
        variable_1 = variable_1
        variable_2 = variable_2
        variable_3 = variable_3
        variable_4 = variable_4 ).

    cl_abap_unit_assert=>assert_equals( act = detail_level exp = '7' ).
    cl_abap_unit_assert=>assert_equals( act = severity exp = 'W' ).
    cl_abap_unit_assert=>assert_equals( act = id exp = '00' ).
    cl_abap_unit_assert=>assert_equals( act = number exp = '001' ).
    cl_abap_unit_assert=>assert_equals( act = variable_1 exp = 'first' ).
  ENDMETHOD.

  METHOD create_message_from_bapiret2.
    DATA message_data TYPE bapiret2.
    DATA severity TYPE if_bali_item_setter=>ty_severity.
    DATA id TYPE if_bali_message_setter=>ty_id.
    DATA number TYPE if_bali_message_setter=>ty_number.
    DATA variable_1 TYPE if_bali_message_setter=>ty_variable.

    message_data-type = 'E'.
    message_data-id = 'ZTEST'.
    message_data-number = '123'.
    message_data-message_v1 = 'value'.

    DATA(message) = cl_bali_message_setter=>create_from_bapiret2( message_data ).
    message->get_all_values(
      IMPORTING
        severity = severity
        id = id
        number = number
        variable_1 = variable_1 ).

    cl_abap_unit_assert=>assert_equals( act = severity exp = 'E' ).
    cl_abap_unit_assert=>assert_equals( act = id exp = 'ZTEST' ).
    cl_abap_unit_assert=>assert_equals( act = number exp = '123' ).
    cl_abap_unit_assert=>assert_equals( act = variable_1 exp = 'value' ).
  ENDMETHOD.

  METHOD test1.

    DATA lv_loghndl    TYPE balloghndl.
    DATA lt_lognumbers TYPE bal_t_lgnm.
    DATA ls_header     TYPE bal_s_log.
    DATA ls_msg        TYPE bal_s_msg.
    DATA lt_handles    TYPE bal_t_logh.

    ls_header-object = 'ZFOOBAR'.

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = ls_header
      IMPORTING
        e_log_handle            = lv_loghndl
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( lv_loghndl ).

    ls_msg-msgty = sy-msgty.
    ls_msg-msgid = sy-msgid.
    ls_msg-msgno = sy-msgno.
    ls_msg-msgv1 = sy-msgv1.
    ls_msg-msgv2 = sy-msgv2.
    ls_msg-msgv3 = sy-msgv3.
    ls_msg-msgv4 = sy-msgv4.

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle     = lv_loghndl
        i_s_msg          = ls_msg
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        log_is_full      = 3
        OTHERS           = 4.
    cl_abap_unit_assert=>assert_subrc( ).

    APPEND lv_loghndl TO lt_handles.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle   = lt_handles
      IMPORTING
        e_new_lognumbers = lt_lognumbers
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( lt_lognumbers ).

  ENDMETHOD.

ENDCLASS.
