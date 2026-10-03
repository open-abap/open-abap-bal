CLASS lcl_time DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS now
      RETURNING
        VALUE(result) TYPE utclong.
ENDCLASS.

* free text and exception items
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

* T100 message items, these also expose the message key
CLASS lcl_bali_message_getter DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_bali_message_getter.

    METHODS constructor
      IMPORTING
        message     TYPE REF TO if_bali_message_setter
        item_number TYPE if_bali_log=>ty_log_item_number.

  PRIVATE SECTION.
    DATA message_text TYPE if_bali_item_getter=>ty_message_text.
ENDCLASS.

CLASS lcl_bali_header_getter DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_bali_header_getter.

    METHODS constructor
      IMPORTING
        header        TYPE REF TO if_bali_header_setter
        items         TYPE if_bali_log=>ty_log_items
        log_timestamp TYPE if_bali_header_getter=>ty_log_timestamp.
ENDCLASS.
