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
ENDCLASS.

CLASS cl_bali_log_db IMPLEMENTATION.
  METHOD get_instance.
    IF instance IS INITIAL.
      CREATE OBJECT instance.
    ENDIF.
    result = instance.
  ENDMETHOD.

  METHOD save_log.
    DATA saved_log TYPE ty_saved_log.

    saved_log-handle = log->get_handle( ).
    saved_log-log = log.

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

    handle = log->get_handle( ).
    DELETE saved_logs WHERE handle = handle.
  ENDMETHOD.

  METHOD load_log.
    DATA saved_log TYPE ty_saved_log.

    READ TABLE saved_logs INTO saved_log WITH TABLE KEY handle = handle.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_bali_not_found.
    ENDIF.

    log = saved_log-log.
  ENDMETHOD.
ENDCLASS.
