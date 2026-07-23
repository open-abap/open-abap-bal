CLASS cl_bali_log DEFINITION PUBLIC CREATE PRIVATE.
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
    DATA header TYPE REF TO cl_bali_header_setter.
    DATA items TYPE if_bali_log=>ty_log_items.

    METHODS constructor.
ENDCLASS.

CLASS cl_bali_log IMPLEMENTATION.
  METHOD constructor.
    next_handle = next_handle + 1.
    handle = CONV #( next_handle ).
  ENDMETHOD.

  METHOD create.
    CREATE OBJECT log TYPE cl_bali_log.
  ENDMETHOD.

  METHOD create_with_header.
    DATA log TYPE REF TO cl_bali_log.
    CREATE OBJECT log.
    log->header ?= header.
    result = log.
  ENDMETHOD.

  METHOD if_bali_log~set_header.
    me->header ?= header.
  ENDMETHOD.

  METHOD if_bali_log~get_handle.
    handle = me->handle.
  ENDMETHOD.

  METHOD if_bali_log~add_item.
    DATA item_line TYPE if_bali_log=>ty_log_item.

    item_line-log_item_number = lines( items ) + 1.
    item_line-item = item.
    item->log_item_number = item_line-log_item_number.
    APPEND item_line TO items.
  ENDMETHOD.

  METHOD if_bali_log~add_all_items_from_other_log.
    DATA(source_items) = source_log->get_all_items( ).

    LOOP AT source_items INTO DATA(source_item).
      DATA(item) = cl_bali_free_text_setter=>create(
        severity = source_item-item->get_severity( )
        text = source_item-item->get_text( ) ).
      item->detail_level = source_item-item->detail_level.
      item->timestamp = source_item-item->timestamp.
      if_bali_log~add_item( item ).
    ENDLOOP.
  ENDMETHOD.

  METHOD if_bali_log~get_all_items.
    result = items.
  ENDMETHOD.

  METHOD if_bali_log~get_item.
    READ TABLE items INTO DATA(item_line) WITH KEY log_item_number = log_item_number.
    IF sy-subrc = 0.
      result = item_line-item.
    ELSE.
      RAISE EXCEPTION TYPE cx_bali_runtime.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
