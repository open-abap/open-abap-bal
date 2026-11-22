CLASS cl_bali_log DEFINITION PUBLIC CREATE PRIVATE GLOBAL FRIENDS cl_bali_log_db.
  PUBLIC SECTION.
    INTERFACES if_bali_log.

    CLASS-METHODS create
      RETURNING
        VALUE(log) TYPE REF TO if_bali_log
      RAISING
        cx_bali_runtime.

    CLASS-METHODS create_with_header
      IMPORTING
        header        TYPE REF TO if_bali_header_setter
      RETURNING
        VALUE(result) TYPE REF TO if_bali_log
      RAISING
        cx_bali_runtime.

  PRIVATE SECTION.
    CLASS-DATA next_handle TYPE i.
    DATA handle TYPE if_bali_log=>ty_handle.
    DATA header TYPE REF TO if_bali_header_setter.
    DATA items TYPE if_bali_log=>ty_log_items.
    DATA created_at TYPE utclong.
    DATA invalidated TYPE if_bali_log=>ty_invalidated.

    METHODS constructor
      IMPORTING
        handle TYPE if_bali_log=>ty_handle OPTIONAL.

* a second log object with the same handle and content, used by cl_bali_log_db:
* what is saved or loaded must not share its memory with the log of the caller
    METHODS copy
      RETURNING
        VALUE(result) TYPE REF TO cl_bali_log.

    METHODS check_not_invalidated
      RAISING
        cx_bali_not_possible.
ENDCLASS.

CLASS cl_bali_log IMPLEMENTATION.
  METHOD constructor.
    IF handle IS INITIAL.
      next_handle = next_handle + 1.
      me->handle = |{ next_handle }|.
    ELSE.
      me->handle = handle.
    ENDIF.
    created_at = lcl_time=>now( ).
  ENDMETHOD.

  METHOD create.
    CREATE OBJECT log TYPE cl_bali_log.
  ENDMETHOD.

  METHOD create_with_header.
    DATA log TYPE REF TO cl_bali_log.
    CREATE OBJECT log.
    log->header = header.
    result = log.
  ENDMETHOD.

  METHOD copy.
    CREATE OBJECT result
      EXPORTING
        handle = handle.
    result->header = header.
    result->items = items.
    result->created_at = created_at.
  ENDMETHOD.

  METHOD check_not_invalidated.
    IF invalidated = abap_true.
      RAISE EXCEPTION TYPE cx_bali_not_possible
        EXPORTING
          error_code = cx_bali_not_possible=>log_was_invalidated.
    ENDIF.
  ENDMETHOD.

  METHOD if_bali_log~release_memory.
    CLEAR header.
    CLEAR items.
    invalidated = abap_true.
  ENDMETHOD.

  METHOD if_bali_log~is_invalidated.
    is_invalidated = invalidated.
  ENDMETHOD.

  METHOD if_bali_log~set_header.
    check_not_invalidated( ).
    me->header = header.
  ENDMETHOD.

  METHOD if_bali_log~get_header.
    check_not_invalidated( ).
    CREATE OBJECT header TYPE lcl_bali_header_getter
      EXPORTING
        header        = me->header
        items         = items
        log_timestamp = created_at.
  ENDMETHOD.

  METHOD if_bali_log~get_handle.
    handle = me->handle.
  ENDMETHOD.

  METHOD if_bali_log~add_item.
    DATA item_line TYPE if_bali_log=>ty_log_item.
    DATA message TYPE REF TO if_bali_message_setter.

    check_not_invalidated( ).
    item_line-log_item_number = lines( items ) + 1.
    TRY.
        message ?= item.
        CREATE OBJECT item_line-item TYPE lcl_bali_message_getter
          EXPORTING
            message     = message
            item_number = item_line-log_item_number.
      CATCH cx_sy_move_cast_error.
        CREATE OBJECT item_line-item TYPE lcl_bali_item_getter
          EXPORTING
            item        = item
            item_number = item_line-log_item_number.
    ENDTRY.
    APPEND item_line TO items.
  ENDMETHOD.

  METHOD if_bali_log~add_all_items_from_other_log.
    check_not_invalidated( ).
" todo
  ENDMETHOD.

  METHOD if_bali_log~get_all_items.
    result = items.
  ENDMETHOD.

  METHOD if_bali_log~get_item.
    check_not_invalidated( ).
    READ TABLE items INTO DATA(item_line) WITH KEY log_item_number = log_item_number.
    IF sy-subrc = 0.
      result ?= item_line-item.
    ELSE.
      RAISE EXCEPTION TYPE cx_bali_runtime.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
