INTERFACE if_bali_header_getter PUBLIC.

  TYPES ty_number_items TYPE i.
  TYPES ty_object_description TYPE c LENGTH 60.
  TYPES ty_subobject_description TYPE c LENGTH 60.
  TYPES ty_object TYPE if_bali_object_handler=>ty_object.
  TYPES ty_subobject TYPE if_bali_object_handler=>ty_subobject.
  TYPES ty_external_id TYPE c LENGTH 100.
  TYPES ty_log_timestamp TYPE utclong.
  TYPES ty_log_user TYPE c LENGTH 12.
  TYPES ty_expiry_date TYPE d.
  TYPES ty_keep_until_expiry TYPE c LENGTH 1.

  DATA object TYPE ty_object READ-ONLY.
  DATA subobject TYPE ty_subobject READ-ONLY.
  DATA external_id TYPE ty_external_id READ-ONLY.
  DATA log_timestamp TYPE ty_log_timestamp READ-ONLY.
  DATA log_user TYPE ty_log_user READ-ONLY.
  DATA expiry_date TYPE ty_expiry_date READ-ONLY.
  DATA keep_until_expiry TYPE ty_keep_until_expiry READ-ONLY.
  DATA number_all_items TYPE ty_number_items READ-ONLY.
  DATA number_abort_items TYPE ty_number_items READ-ONLY.
  DATA number_error_items TYPE ty_number_items READ-ONLY.
  DATA number_warning_items TYPE ty_number_items READ-ONLY.
  DATA number_information_items TYPE ty_number_items READ-ONLY.
  DATA number_status_items TYPE ty_number_items READ-ONLY.

  METHODS get_object_description
    RETURNING
      VALUE(object_description) TYPE ty_object_description.

  METHODS get_subobject_description
    RETURNING
      VALUE(subobject_description) TYPE ty_subobject_description.

ENDINTERFACE.
