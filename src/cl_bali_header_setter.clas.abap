CLASS cl_bali_header_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
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
        VALUE(result)         TYPE REF TO cl_bali_header_setter.

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
