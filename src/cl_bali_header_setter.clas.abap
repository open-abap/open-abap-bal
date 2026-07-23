CLASS cl_bali_header_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    INTERFACES if_bali_header_setter.

    TYPES ty_object TYPE if_bali_object_handler=>ty_object.
    TYPES ty_subobject TYPE if_bali_object_handler=>ty_subobject.
    TYPES ty_external_id TYPE c LENGTH 100.

    CLASS-METHODS create
      IMPORTING
        object                TYPE ty_object
        subobject             TYPE ty_subobject OPTIONAL
        external_id           TYPE ty_external_id OPTIONAL
        expiration            TYPE i OPTIONAL
        keep_until_expiration TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(result)         TYPE REF TO if_bali_header_setter.

    METHODS get_object
      RETURNING
        VALUE(result) TYPE ty_object.

    METHODS get_subobject
      RETURNING
        VALUE(result) TYPE ty_subobject.

  PRIVATE SECTION.
    DATA object TYPE ty_object.
    DATA subobject TYPE ty_subobject.
    DATA external_id TYPE ty_external_id.
    DATA expiry_date TYPE d.
    DATA keep_until_expiry TYPE abap_bool.
ENDCLASS.

CLASS cl_bali_header_setter IMPLEMENTATION.
  METHOD create.
    DATA lo_setter TYPE REF TO cl_bali_header_setter.
    CREATE OBJECT lo_setter.
    lo_setter->object = object.
    lo_setter->subobject = subobject.
    lo_setter->external_id = external_id.
    result ?= lo_setter.
  ENDMETHOD.

  METHOD get_object.
    result = object.
  ENDMETHOD.

  METHOD get_subobject.
    result = subobject.
  ENDMETHOD.

  METHOD if_bali_header_setter~set_expiry.
    IF expiry_date IS NOT INITIAL.
      me->expiry_date = expiry_date.
    ENDIF.
    me->keep_until_expiry = keep_until_expiry.
    new_header = me.
  ENDMETHOD.
ENDCLASS.
