CLASS cl_bali_log_db DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    INTERFACES if_bali_log_db.
    ALIASES delete_log FOR if_bali_log_db~delete_log.
    ALIASES load_log FOR if_bali_log_db~load_log.
    ALIASES save_log FOR if_bali_log_db~save_log.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(result) TYPE REF TO if_bali_log_db.

    METHODS save_log_2nd_db_connection
      IMPORTING
        log                        TYPE REF TO if_bali_log
        assign_to_current_appl_job TYPE abap_bool OPTIONAL
      RAISING
        cx_bali_runtime.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_saved_log,
        handle TYPE if_bali_log=>ty_handle,
        log    TYPE REF TO if_bali_log,
      END OF ty_saved_log.

    CLASS-DATA instance TYPE REF TO cl_bali_log_db.
* there is no database off-stack, the saved logs are kept in memory by handle
    DATA saved_logs TYPE SORTED TABLE OF ty_saved_log WITH UNIQUE KEY handle.

    CLASS-METHODS check_not_invalidated
      IMPORTING
        log TYPE REF TO if_bali_log
      RAISING
        cx_bali_not_possible.

* the "database" keeps its own copy: releasing the memory of a log, or changing
* it after the save, does not touch what was saved
    CLASS-METHODS copy_of
      IMPORTING
        log           TYPE REF TO if_bali_log
      RETURNING
        VALUE(result) TYPE REF TO if_bali_log.
ENDCLASS.

CLASS cl_bali_log_db IMPLEMENTATION.
  METHOD get_instance.
    IF instance IS INITIAL.
      CREATE OBJECT instance.
    ENDIF.
    result = instance.
  ENDMETHOD.

  METHOD check_not_invalidated.
    IF log->is_invalidated( ) = abap_true.
      RAISE EXCEPTION TYPE cx_bali_not_possible
        EXPORTING
          error_code = cx_bali_not_possible=>log_was_invalidated.
    ENDIF.
  ENDMETHOD.

  METHOD copy_of.
    DATA in_memory TYPE REF TO cl_bali_log.

    TRY.
        in_memory ?= log.
        result = in_memory->copy( ).
      CATCH cx_sy_move_cast_error.
* not the log of this library, e.g. a test double: nothing to copy
        result = log.
    ENDTRY.
  ENDMETHOD.

  METHOD save_log.
    DATA saved_log TYPE ty_saved_log.

    check_not_invalidated( log ).

    saved_log-handle = log->get_handle( ).
    saved_log-log = copy_of( log ).

    DELETE saved_logs WHERE handle = saved_log-handle.
    INSERT saved_log INTO TABLE saved_logs.
  ENDMETHOD.

  METHOD save_log_2nd_db_connection.
    save_log(
      log = log
      use_2nd_db_connection = abap_true
      assign_to_current_appl_job = assign_to_current_appl_job ).
  ENDMETHOD.

  METHOD if_bali_log_db~delete_log.
    DATA handle TYPE if_bali_log=>ty_handle.

    check_not_invalidated( log ).

    handle = log->get_handle( ).
    DELETE saved_logs WHERE handle = handle.
  ENDMETHOD.

  METHOD load_log.
    DATA saved_log TYPE ty_saved_log.

    READ TABLE saved_logs INTO saved_log WITH TABLE KEY handle = handle.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_bali_not_found.
    ENDIF.

    log = copy_of( saved_log-log ).
  ENDMETHOD.
ENDCLASS.
