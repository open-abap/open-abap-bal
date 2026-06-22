CLASS cl_bali_free_text_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    TYPES ty_text     TYPE c LENGTH 200.
    TYPES ty_severity TYPE c LENGTH 1.

    DATA category TYPE string VALUE 'FREE_TEXT'.
    DATA severity TYPE ty_severity.
    DATA detail_level TYPE i VALUE 1.
    DATA log_item_number TYPE if_bali_log=>ty_log_item_number.
    DATA timestamp TYPE timestampl.

    CLASS-METHODS create
      IMPORTING
        severity      TYPE ty_severity
        text          TYPE ty_text
      RETURNING
        VALUE(result) TYPE REF TO cl_bali_free_text_setter.

    METHODS get_severity
      RETURNING
        VALUE(result) TYPE ty_severity.

    METHODS get_text
      RETURNING
        VALUE(result) TYPE ty_text.

    METHODS get_message_text
      RETURNING
        VALUE(result) TYPE string.

  PRIVATE SECTION.
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

  METHOD get_message_text.
    result = text.
  ENDMETHOD.

ENDCLASS.
