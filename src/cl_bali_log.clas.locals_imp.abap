CLASS lcl_bali_item_getter IMPLEMENTATION.
  METHOD constructor.
    DATA message TYPE REF TO if_bali_message_setter.
    DATA exception_item TYPE REF TO if_bali_exception_setter.
    DATA free_text TYPE REF TO cl_bali_free_text_setter.
    DATA exception TYPE REF TO cx_root.
    DATA id TYPE if_bali_message_setter=>ty_id.
    DATA number TYPE if_bali_message_setter=>ty_number.
    DATA variable_1 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_2 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_3 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_4 TYPE if_bali_message_setter=>ty_variable.

    if_bali_item_getter~log_item_number = item_number.

    TRY.
        message ?= item.
        message->get_all_values(
          IMPORTING
            detail_level = if_bali_item_getter~detail_level
            severity = if_bali_item_getter~severity
            id = id
            number = number
            variable_1 = variable_1
            variable_2 = variable_2
            variable_3 = variable_3
            variable_4 = variable_4 ).
        if_bali_item_getter~category = if_bali_constants=>c_category_message.
        MESSAGE ID id TYPE if_bali_item_getter~severity NUMBER number
          WITH variable_1 variable_2 variable_3 variable_4
          INTO message_text.
        RETURN.
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    TRY.
        exception_item ?= item.
        exception_item->get_all_values(
          IMPORTING
            detail_level = if_bali_item_getter~detail_level
            severity = if_bali_item_getter~severity
            exception = exception ).
        if_bali_item_getter~category = if_bali_constants=>c_category_exception.
        IF exception IS BOUND.
          message_text = exception->get_text( ).
        ENDIF.
        RETURN.
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    free_text ?= item.
    if_bali_item_getter~category = if_bali_constants=>c_category_free_text.
    if_bali_item_getter~detail_level = free_text->detail_level.
    if_bali_item_getter~severity = free_text->get_severity( ).
    message_text = free_text->get_text( ).
  ENDMETHOD.

  METHOD if_bali_item_getter~get_message_text.
    message_text = me->message_text.
  ENDMETHOD.
ENDCLASS.
