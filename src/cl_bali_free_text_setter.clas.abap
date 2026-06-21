CLASS cl_bali_free_text_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    TYPES ty_text TYPE string.
    TYPES ty_severity TYPE c LENGTH 1.

    CLASS-METHODS create
      IMPORTING
        severity TYPE ty_severity
        text     TYPE ty_text
      RETURNING
        VALUE(result) TYPE REF TO cl_bali_free_text_setter.

    METHODS get_severity
      RETURNING
        VALUE(result) TYPE ty_severity.

    METHODS get_text
      RETURNING
        VALUE(result) TYPE ty_text.

  PRIVATE SECTION.
    DATA severity TYPE ty_severity.
    DATA text TYPE ty_text.
ENDCLASS.

CLASS cl_bali_free_text_setter IMPLEMENTATION.

  METHOD create.
    CREATE OBJECT result.
    result->severity = severity.
    result->text = text.
  ENDMETHOD.

  METHOD get_severity.
    result = severity.
  ENDMETHOD.

  METHOD get_text.
    result = text.
  ENDMETHOD.

ENDCLASS.
