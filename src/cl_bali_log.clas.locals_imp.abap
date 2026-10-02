CLASS lcl_time IMPLEMENTATION.
  METHOD now.
* utclong_current( ) is not available in the open-abap runtime
    DATA stamp TYPE timestamp.

    GET TIME STAMP FIELD stamp.
    result = cl_abap_tstmp=>tstmp2utclong( stamp ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_bali_item_getter IMPLEMENTATION.
  METHOD constructor.
    DATA exception_item TYPE REF TO if_bali_exception_setter.
    DATA free_text TYPE REF TO cl_bali_free_text_setter.
    DATA exception TYPE REF TO cx_root.

    if_bali_item_getter~log_item_number = item_number.
* on a real system the item gets its time stamp when it is added to the log
    if_bali_item_getter~timestamp = lcl_time=>now( ).

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

CLASS lcl_bali_message_getter IMPLEMENTATION.
  METHOD constructor.
    if_bali_item_getter~log_item_number = item_number.
    if_bali_item_getter~timestamp = lcl_time=>now( ).
    if_bali_item_getter~category = if_bali_constants=>c_category_message.

    message->get_all_values(
      IMPORTING
        detail_level = if_bali_item_getter~detail_level
        severity = if_bali_item_getter~severity
        id = if_bali_message_getter~id
        number = if_bali_message_getter~number
        variable_1 = if_bali_message_getter~variable_1
        variable_2 = if_bali_message_getter~variable_2
        variable_3 = if_bali_message_getter~variable_3
        variable_4 = if_bali_message_getter~variable_4 ).

    MESSAGE ID if_bali_message_getter~id TYPE if_bali_item_getter~severity NUMBER if_bali_message_getter~number
      WITH if_bali_message_getter~variable_1 if_bali_message_getter~variable_2
           if_bali_message_getter~variable_3 if_bali_message_getter~variable_4
      INTO message_text.
  ENDMETHOD.

  METHOD if_bali_item_getter~get_message_text.
    message_text = me->message_text.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_bali_header_getter IMPLEMENTATION.
  METHOD constructor.
    DATA item_line TYPE if_bali_log=>ty_log_item.

    IF header IS BOUND.
      header->get_all_values(
        IMPORTING
          object = if_bali_header_getter~object
          subobject = if_bali_header_getter~subobject
          external_id = if_bali_header_getter~external_id
          expiry_date = if_bali_header_getter~expiry_date
          keep_until_expiry = if_bali_header_getter~keep_until_expiry ).
    ENDIF.

    if_bali_header_getter~log_timestamp = log_timestamp.
    if_bali_header_getter~log_user = sy-uname.

    if_bali_header_getter~number_all_items = lines( items ).
    LOOP AT items INTO item_line.
      CASE item_line-item->severity.
        WHEN if_bali_constants=>c_severity_termination OR if_bali_constants=>c_severity_exit.
          if_bali_header_getter~number_abort_items = if_bali_header_getter~number_abort_items + 1.
        WHEN if_bali_constants=>c_severity_error.
          if_bali_header_getter~number_error_items = if_bali_header_getter~number_error_items + 1.
        WHEN if_bali_constants=>c_severity_warning.
          if_bali_header_getter~number_warning_items = if_bali_header_getter~number_warning_items + 1.
        WHEN if_bali_constants=>c_severity_information.
          if_bali_header_getter~number_information_items = if_bali_header_getter~number_information_items + 1.
        WHEN OTHERS.
          if_bali_header_getter~number_status_items = if_bali_header_getter~number_status_items + 1.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_bali_header_getter~get_object_description.
* application log objects are not known off-stack
    RETURN.
  ENDMETHOD.

  METHOD if_bali_header_getter~get_subobject_description.
    RETURN.
  ENDMETHOD.
ENDCLASS.
