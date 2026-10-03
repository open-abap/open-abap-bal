INTERFACE if_bali_log_db PUBLIC.

  TYPES ty_handle TYPE balloghndl.
  TYPES ty_read_only_header TYPE abap_bool.

  METHODS delete_log
    IMPORTING
      log TYPE REF TO if_bali_log
    RAISING
      cx_bali_runtime.

  METHODS save_log
      IMPORTING
        log                        TYPE REF TO if_bali_log
        use_2nd_db_connection      TYPE abap_bool OPTIONAL
        assign_to_current_appl_job TYPE abap_bool OPTIONAL
      RAISING
        cx_bali_runtime.

  METHODS load_log
    IMPORTING
      handle           TYPE ty_handle
      read_only_header TYPE ty_read_only_header DEFAULT abap_false
    RETURNING
      VALUE(log)       TYPE REF TO if_bali_log
    RAISING
      cx_bali_runtime.

ENDINTERFACE.
