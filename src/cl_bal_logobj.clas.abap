CLASS cl_bal_logobj DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_log_object        TYPE clike
        i_default_subobject TYPE clike
        i_reorg_in_days     TYPE clike
        i_extnumber         TYPE string.

    METHODS add_exception
      IMPORTING
        ix_exception TYPE REF TO cx_root.

    METHODS add_msg
      IMPORTING
        foo TYPE clike.

    TYPES: BEGIN OF ty_log,
             lognumber TYPE balognr,
           END OF ty_log.
    TYPES ty_logs TYPE STANDARD TABLE OF ty_log WITH DEFAULT KEY.

    METHODS save
      EXPORTING
        et_lognumbers TYPE ty_logs.
  PRIVATE SECTION.
    DATA mv_extnumber TYPE string.
ENDCLASS.

CLASS cl_bal_logobj IMPLEMENTATION.

  METHOD constructor.
    mv_extnumber = i_extnumber.
  ENDMETHOD.

  METHOD add_msg.
* todo
    RETURN.
  ENDMETHOD.

  METHOD add_exception.
* todo
    RETURN.
  ENDMETHOD.

  METHOD save.
* todo
    APPEND INITIAL LINE TO et_lognumbers.
  ENDMETHOD.

ENDCLASS.