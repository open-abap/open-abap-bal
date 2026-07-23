INTERFACE if_bali_exception_setter PUBLIC.
  INTERFACES if_bali_item_setter.

  TYPES ty_exception TYPE REF TO cx_root.

  METHODS set_exception
    IMPORTING
      severity                 TYPE if_bali_item_setter=>ty_severity OPTIONAL
      exception                TYPE ty_exception
    RETURNING
      VALUE(new_exception_obj) TYPE REF TO if_bali_exception_setter.

  METHODS set_detail_level
    IMPORTING
      detail_level             TYPE if_bali_item_setter=>ty_detail_level
    RETURNING
      VALUE(new_exception_obj) TYPE REF TO if_bali_exception_setter.

  METHODS get_all_values
    EXPORTING
      detail_level TYPE if_bali_item_setter=>ty_detail_level
      severity     TYPE if_bali_item_setter=>ty_severity
      exception    TYPE ty_exception.
ENDINTERFACE.
