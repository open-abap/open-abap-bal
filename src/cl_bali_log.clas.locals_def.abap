CLASS lcl_bali_item_getter DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_bali_item_getter.

    METHODS constructor
      IMPORTING
        item        TYPE REF TO if_bali_item_setter
        item_number TYPE if_bali_log=>ty_log_item_number.

  PRIVATE SECTION.
    DATA message_text TYPE if_bali_item_getter=>ty_message_text.
ENDCLASS.
