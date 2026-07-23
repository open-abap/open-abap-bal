CLASS cl_bali_log_db DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(result) TYPE REF TO cl_bali_log_db.

    METHODS save_log
      IMPORTING
        log                        TYPE REF TO if_bali_log
        use_2nd_db_connection      TYPE abap_bool OPTIONAL
        assign_to_current_appl_job TYPE abap_bool OPTIONAL
      RAISING
        cx_bali_runtime.

    METHODS save_log_2nd_db_connection
      IMPORTING
        log                        TYPE REF TO if_bali_log
        assign_to_current_appl_job TYPE abap_bool OPTIONAL
      RAISING
        cx_bali_runtime.

    METHODS load_log
      IMPORTING
        handle           TYPE if_bali_log=>ty_handle
        read_only_header TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(result)    TYPE REF TO if_bali_log
      RAISING
        cx_bali_runtime.

  PRIVATE SECTION.
    CLASS-DATA instance TYPE REF TO cl_bali_log_db.
    DATA last_log TYPE REF TO if_bali_log.
ENDCLASS.

CLASS cl_bali_log_db IMPLEMENTATION.
  METHOD get_instance.
    IF instance IS INITIAL.
      CREATE OBJECT instance.
    ENDIF.
    result = instance.
  ENDMETHOD.

  METHOD save_log.
    last_log = log.
  ENDMETHOD.

  METHOD save_log_2nd_db_connection.
    save_log(
      log = log
      use_2nd_db_connection = abap_true
      assign_to_current_appl_job = assign_to_current_appl_job ).
  ENDMETHOD.

  METHOD load_log.
    IF last_log IS INITIAL.
      result = cl_bali_log=>create_with_header(
        header = cl_bali_header_setter=>create( object = CONV #( handle ) ) ).
    ELSE.
      result = last_log.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
