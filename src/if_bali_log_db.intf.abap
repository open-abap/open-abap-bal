INTERFACE if_bali_log_db PUBLIC.

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

ENDINTERFACE.
