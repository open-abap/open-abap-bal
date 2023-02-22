CLASS cl_bal_logobj DEFINITION PUBLIC.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_log,
             lognumber TYPE balognr,
           END OF ty_log.
    TYPES ty_logs TYPE STANDARD TABLE OF ty_log WITH DEFAULT KEY.

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

    METHODS save
      EXPORTING
        et_lognumbers TYPE ty_logs.

    METHODS add_statustext
      IMPORTING
        i_statustext TYPE string
      RAISING
        cx_bal_exception.

    METHODS add_errortext
      IMPORTING
        i_errortext TYPE string
      RAISING
        cx_bal_exception.
  PRIVATE SECTION.
    DATA mv_extnumber TYPE string.
ENDCLASS.

CLASS cl_bal_logobj IMPLEMENTATION.

  METHOD constructor.
    mv_extnumber = i_extnumber.
  ENDMETHOD.

  METHOD add_errortext.
* todo
    RETURN.
  ENDMETHOD.

  METHOD add_statustext.
* todo
    RETURN.
  ENDMETHOD.

  METHOD add_msg.
* todo
    RETURN.
  ENDMETHOD.

  METHOD add_exception.
* todo
    WRITE '@KERNEL console.dir(ix_exception);'.

    RETURN.
  ENDMETHOD.

  METHOD save.
* todo
    FIELD-SYMBOLS <fs> LIKE LINE OF et_lognumbers.
    APPEND INITIAL LINE TO et_lognumbers ASSIGNING <fs>.
    <fs>-lognumber = '00000000000000000001'.
  ENDMETHOD.

ENDCLASS.