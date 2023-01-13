CLASS cl_bal_logobj DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_log_object        TYPE clike
        i_default_subobject TYPE clike
        i_reorg_in_days     TYPE clike
        i_extnumber         TYPE clike.

    METHODS add_exception
      IMPORTING
        ix_exception TYPE REF TO cx_root.

    METHODS save
      EXPORTING
        et_lognumbers TYPE string_table.
ENDCLASS.

CLASS cl_bal_logobj IMPLEMENTATION.

  METHOD constructor.
* todo
    RETURN.
  ENDMETHOD.

  METHOD add_exception.
* todo
    RETURN.
  ENDMETHOD.

  METHOD save.
* todo
    RETURN.
  ENDMETHOD.

ENDCLASS.