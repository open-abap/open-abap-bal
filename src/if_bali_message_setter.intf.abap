INTERFACE if_bali_message_setter PUBLIC.
  INTERFACES if_bali_item_setter.

  TYPES ty_count TYPE i.
  TYPES ty_id TYPE c LENGTH 20.
  TYPES ty_number TYPE n LENGTH 3.
  TYPES ty_variable TYPE c LENGTH 50.

  METHODS set_attributes
    IMPORTING
      severity           TYPE if_bali_item_setter=>ty_severity OPTIONAL
      id                 TYPE ty_id
      number             TYPE ty_number
      variable_1         TYPE ty_variable OPTIONAL
      variable_2         TYPE ty_variable OPTIONAL
      variable_3         TYPE ty_variable OPTIONAL
      variable_4         TYPE ty_variable OPTIONAL
    RETURNING
      VALUE(new_message) TYPE REF TO if_bali_message_setter.

  METHODS set_from_sy
    RETURNING
      VALUE(new_message) TYPE REF TO if_bali_message_setter.

  METHODS set_from_bapiret2
    IMPORTING
      message_data       TYPE bapiret2
    RETURNING
      VALUE(new_message) TYPE REF TO if_bali_message_setter.

  METHODS set_detail_level
    IMPORTING
      detail_level       TYPE if_bali_item_setter=>ty_detail_level
    RETURNING
      VALUE(new_message) TYPE REF TO if_bali_message_setter.

  METHODS get_all_values
    EXPORTING
      detail_level TYPE if_bali_item_setter=>ty_detail_level
      severity     TYPE if_bali_item_setter=>ty_severity
      id           TYPE ty_id
      number       TYPE ty_number
      variable_1   TYPE ty_variable
      variable_2   TYPE ty_variable
      variable_3   TYPE ty_variable
      variable_4   TYPE ty_variable.
ENDINTERFACE.
