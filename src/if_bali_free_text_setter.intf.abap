INTERFACE if_bali_free_text_setter PUBLIC.
  INTERFACES if_bali_item_setter.

  TYPES ty_text TYPE c LENGTH 200.
  ALIASES ty_detail_level FOR if_bali_item_setter~ty_detail_level.

  METHODS set_detail_level
    IMPORTING
      detail_level         TYPE ty_detail_level
    RETURNING
      VALUE(new_free_text) TYPE REF TO if_bali_free_text_setter.
ENDINTERFACE.