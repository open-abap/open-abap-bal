INTERFACE if_bali_header_setter PUBLIC.

  METHODS set_expiry
    IMPORTING
      expiry_date       TYPE d
      keep_until_expiry TYPE abap_bool OPTIONAL
    RETURNING
      VALUE(new_header) TYPE REF TO if_bali_header_setter.

ENDINTERFACE.
