CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test1.

    DATA lv_loghndl    TYPE balloghndl.
    DATA lt_lognumbers TYPE bal_t_lgnm.
    DATA ls_header     TYPE bal_s_log.

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

  ENDMETHOD.

ENDCLASS.