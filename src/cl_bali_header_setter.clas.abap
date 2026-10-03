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
        VALUE(result)         TYPE REF TO if_bali_header_setter
      RAISING
        cx_bali_runtime.

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

    CLASS-METHODS check_object_exists
      IMPORTING
        object    TYPE ty_object
        subobject TYPE ty_subobject
      RAISING
        cx_bali_invalid_parameter.
ENDCLASS.

CLASS cl_bali_header_setter IMPLEMENTATION.
  METHOD create.
    DATA lo_setter TYPE REF TO cl_bali_header_setter.

    check_object_exists(
      object    = object
      subobject = subobject ).

    CREATE OBJECT lo_setter.
    lo_setter->object = object.
    lo_setter->subobject = subobject.
    lo_setter->external_id = external_id.
    result ?= lo_setter.
  ENDMETHOD.

  METHOD check_object_exists.
* the application log objects are read from BALOBJ and BALSUB, as on a real system.
* without a database, or with no object defined at all, nothing is known about
* the objects and every name is accepted
    DATA lv_connected TYPE abap_bool.
    DATA lv_object TYPE balobj-object.
    DATA lv_subobject TYPE balsub-subobject.

    IF object IS INITIAL.
      RETURN.
    ENDIF.

    WRITE '@KERNEL lv_connected.set(abap.context.databaseConnections["DEFAULT"] === undefined ? "" : "X");'.
    IF lv_connected = abap_false.
      RETURN.
    ENDIF.

    TRY.
        SELECT SINGLE object FROM balobj INTO @lv_object.
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.

        SELECT SINGLE object FROM balobj INTO @lv_object WHERE object = @object.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_bali_invalid_parameter.
        ENDIF.

        IF subobject IS NOT INITIAL.
          SELECT SINGLE subobject FROM balsub INTO @lv_subobject
            WHERE object = @object AND subobject = @subobject.
          IF sy-subrc <> 0.
            RAISE EXCEPTION TYPE cx_bali_invalid_parameter.
          ENDIF.
        ENDIF.
      CATCH cx_sy_dynamic_osql_error.
* the tables are not reachable, e.g. while SQL test doubles are active
        RETURN.
    ENDTRY.
  ENDMETHOD.

  METHOD get_object.
    result = object.
  ENDMETHOD.

  METHOD get_subobject.
    result = subobject.
  ENDMETHOD.

  METHOD if_bali_header_setter~get_all_values.
    object = me->object.
    subobject = me->subobject.
    external_id = me->external_id.
    expiry_date = me->expiry_date.
    keep_until_expiry = me->keep_until_expiry.
  ENDMETHOD.

  METHOD if_bali_header_setter~set_expiry.
    IF expiry_date IS NOT INITIAL.
      me->expiry_date = expiry_date.
    ENDIF.
    me->keep_until_expiry = keep_until_expiry.
    new_header = me.
  ENDMETHOD.
ENDCLASS.
