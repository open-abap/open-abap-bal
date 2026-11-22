CLASS cx_bali_not_possible DEFINITION PUBLIC INHERITING FROM cx_bali_runtime FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES ty_error_code TYPE i.

    CONSTANTS no_authorization TYPE ty_error_code VALUE 1.
    CONSTANTS object_not_allowed TYPE ty_error_code VALUE 2.
    CONSTANTS too_many_items TYPE ty_error_code VALUE 3.
    CONSTANTS entry_is_locked TYPE ty_error_code VALUE 4.
    CONSTANTS save_not_allowed TYPE ty_error_code VALUE 5.
    CONSTANTS log_was_invalidated TYPE ty_error_code VALUE 6.

    DATA error_code TYPE ty_error_code.

    METHODS constructor
      IMPORTING
        previous   LIKE previous OPTIONAL
        error_code TYPE ty_error_code OPTIONAL.
ENDCLASS.

CLASS cx_bali_not_possible IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    me->error_code = error_code.
  ENDMETHOD.
ENDCLASS.
