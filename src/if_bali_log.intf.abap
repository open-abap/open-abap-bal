INTERFACE if_bali_log PUBLIC.
  TYPES ty_handle TYPE string.
  TYPES ty_log_item_number TYPE i.

  TYPES:
    BEGIN OF ty_log_item,
      log_item_number TYPE ty_log_item_number,
      item            TYPE REF TO cl_bali_free_text_setter,
    END OF ty_log_item.
  TYPES ty_log_items TYPE STANDARD TABLE OF ty_log_item WITH DEFAULT KEY.

  METHODS get_handle
    RETURNING
      VALUE(handle) TYPE ty_handle.

  METHODS set_header
    IMPORTING
      header TYPE REF TO if_bali_header_setter
    RAISING
      cx_bali_runtime.

  METHODS add_item
    IMPORTING
      item TYPE REF TO if_bali_item_setter
    RAISING
      cx_bali_runtime.

  METHODS add_all_items_from_other_log
    IMPORTING
      source_log TYPE REF TO if_bali_log
    RAISING
      cx_bali_runtime.

  METHODS get_all_items
    RETURNING
      VALUE(result) TYPE ty_log_items.

  METHODS get_item
    IMPORTING
      log_item_number TYPE ty_log_item_number
    RETURNING
      VALUE(result)   TYPE REF TO cl_bali_free_text_setter
    RAISING
      cx_bali_runtime.
ENDINTERFACE.
