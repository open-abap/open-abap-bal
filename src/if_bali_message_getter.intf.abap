INTERFACE if_bali_message_getter PUBLIC.

  INTERFACES if_bali_item_getter.

  ALIASES category FOR if_bali_item_getter~category.
  ALIASES detail_level FOR if_bali_item_getter~detail_level.
  ALIASES log_item_number FOR if_bali_item_getter~log_item_number.
  ALIASES severity FOR if_bali_item_getter~severity.
  ALIASES timestamp FOR if_bali_item_getter~timestamp.
  ALIASES get_message_text FOR if_bali_item_getter~get_message_text.

  TYPES ty_count TYPE i.
  TYPES ty_id TYPE c LENGTH 20.
  TYPES ty_number TYPE n LENGTH 3.
  TYPES ty_variable TYPE c LENGTH 50.

  DATA id TYPE ty_id READ-ONLY.
  DATA number TYPE ty_number READ-ONLY.
  DATA variable_1 TYPE ty_variable READ-ONLY.
  DATA variable_2 TYPE ty_variable READ-ONLY.
  DATA variable_3 TYPE ty_variable READ-ONLY.
  DATA variable_4 TYPE ty_variable READ-ONLY.
  DATA count TYPE ty_count READ-ONLY.

ENDINTERFACE.
