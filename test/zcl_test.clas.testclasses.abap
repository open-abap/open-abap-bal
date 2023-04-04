CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

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