INTERFACE if_bali_header_setter PUBLIC.

  TYPES ty_object TYPE if_bali_object_handler=>ty_object.
  TYPES ty_subobject TYPE if_bali_object_handler=>ty_subobject.
  TYPES ty_external_id TYPE c LENGTH 100.
  TYPES ty_expiry_date TYPE d.
  TYPES ty_keep_until_expiry TYPE c LENGTH 1.

  METHODS set_expiry
    IMPORTING
      expiry_date       TYPE d
      keep_until_expiry TYPE abap_bool OPTIONAL
    RETURNING
      VALUE(new_header) TYPE REF TO if_bali_header_setter.

  METHODS get_all_values
    EXPORTING
      object            TYPE ty_object
      subobject         TYPE ty_subobject
      external_id       TYPE ty_external_id
      expiry_date       TYPE ty_expiry_date
      keep_until_expiry TYPE ty_keep_until_expiry.

ENDINTERFACE.
