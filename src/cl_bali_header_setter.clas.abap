CLASS cl_bali_header_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS create
      IMPORTING
        object        TYPE if_bali_object_handler=>ty_object
        subobject     TYPE if_bali_object_handler=>ty_object OPTIONAL
        external_id   TYPE string OPTIONAL
        expiration    TYPE i OPTIONAL
        keep_until_expiration TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO cl_bali_header_setter.

    METHODS get_object
      RETURNING
        VALUE(result) TYPE if_bali_object_handler=>ty_object.

    METHODS get_subobject
      RETURNING
        VALUE(result) TYPE if_bali_object_handler=>ty_object.

  PRIVATE SECTION.
    DATA object TYPE if_bali_object_handler=>ty_object.
    DATA subobject TYPE if_bali_object_handler=>ty_object.
    DATA external_id TYPE string.
ENDCLASS.

CLASS cl_bali_header_setter IMPLEMENTATION.
  METHOD create.
    CREATE OBJECT result.
    result->object = object.
    result->subobject = subobject.
    result->external_id = external_id.
  ENDMETHOD.

  METHOD get_object.
    result = object.
  ENDMETHOD.

  METHOD get_subobject.
    result = subobject.
  ENDMETHOD.
ENDCLASS.
