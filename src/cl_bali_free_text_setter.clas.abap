CLASS cl_bali_free_text_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    INTERFACES if_bali_item_setter.
    INTERFACES if_bali_free_text_setter.

    ALIASES ty_severity FOR if_bali_item_setter~ty_severity.
    ALIASES ty_text FOR if_bali_free_text_setter~ty_text.

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
        VALUE(result) TYPE REF TO if_bali_free_text_setter.

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
  METHOD if_bali_free_text_setter~set_detail_level.
    me->detail_level = detail_level.
  ENDMETHOD.

  METHOD create.
    DATA lo_setter TYPE REF TO cl_bali_free_text_setter.
    CREATE OBJECT lo_setter.
    lo_setter->severity = severity.
    lo_setter->text = text.
    result ?= lo_setter.
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
