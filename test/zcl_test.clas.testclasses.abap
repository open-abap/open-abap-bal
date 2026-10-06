CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS create_empty_log FOR TESTING RAISING cx_bali_runtime.
    METHODS get_log_handle FOR TESTING RAISING cx_bali_runtime.
    METHODS save_log_2nd_connection FOR TESTING RAISING cx_bali_runtime.
    METHODS set_log_header FOR TESTING RAISING cx_bali_runtime.
    METHODS create_message FOR TESTING.
    METHODS create_message_from_bapiret2 FOR TESTING.
    METHODS create_exception FOR TESTING.
    METHODS add_item FOR TESTING RAISING cx_bali_runtime.
    METHODS test1 FOR TESTING RAISING cx_static_check.
    METHODS get_header_values FOR TESTING RAISING cx_bali_runtime.
    METHODS get_header_without_header FOR TESTING RAISING cx_bali_runtime.
    METHODS get_header_counts_items FOR TESTING RAISING cx_bali_runtime.
    METHODS item_has_timestamp FOR TESTING RAISING cx_bali_runtime.
    METHODS message_item_exposes_key FOR TESTING RAISING cx_bali_runtime.
    METHODS free_text_is_not_a_message FOR TESTING RAISING cx_bali_runtime.
    METHODS load_saved_log_by_handle FOR TESTING RAISING cx_bali_runtime.
    METHODS load_picks_log_by_handle FOR TESTING RAISING cx_bali_runtime.
    METHODS load_unknown_handle_raises FOR TESTING.
    METHODS load_deleted_log_raises FOR TESTING RAISING cx_bali_runtime.
    METHODS display_profile_single_log FOR TESTING.
    METHODS log_filter_ranges FOR TESTING.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD create_empty_log.
    DATA object TYPE cl_bali_header_setter=>ty_object.
    DATA subobject TYPE cl_bali_header_setter=>ty_subobject.
    DATA external_id TYPE cl_bali_header_setter=>ty_external_id.
    DATA(log) = cl_bali_log=>create( ).

    cl_abap_unit_assert=>assert_initial( object ).
    cl_abap_unit_assert=>assert_initial( subobject ).
    cl_abap_unit_assert=>assert_initial( external_id ).
    cl_abap_unit_assert=>assert_bound( log ).
    cl_abap_unit_assert=>assert_initial( log->get_all_items( ) ).
  ENDMETHOD.

  METHOD get_log_handle.
    DATA(log) = cl_bali_log=>create( ).
    DATA(handle) = log->get_handle( ).

    cl_abap_unit_assert=>assert_not_initial( handle ).
    cl_abap_unit_assert=>assert_equals( act = log->get_handle( ) exp = handle ).
  ENDMETHOD.

  METHOD save_log_2nd_connection.
    DATA(log) = cl_bali_log=>create( ).

    cl_bali_log_db=>get_instance( )->save_log(
      log = log
      use_2nd_db_connection = abap_true ).
  ENDMETHOD.

  METHOD set_log_header.
    DATA(log) = cl_bali_log=>create( ).
    DATA(header) = cl_bali_header_setter=>create( object = 'ZFOOBAR' ).

    log->set_header( header ).
  ENDMETHOD.

  METHOD create_message.
    DATA detail_level TYPE if_bali_item_setter=>ty_detail_level.
    DATA severity TYPE if_bali_item_setter=>ty_severity.
    DATA id TYPE if_bali_message_setter=>ty_id.
    DATA number TYPE if_bali_message_setter=>ty_number.
    DATA variable_1 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_2 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_3 TYPE if_bali_message_setter=>ty_variable.
    DATA variable_4 TYPE if_bali_message_setter=>ty_variable.

    DATA(message) = cl_bali_message_setter=>create(
      severity = if_bali_constants=>c_severity_warning
      id = '00'
      number = '001'
      variable_1 = 'first' ).

    message->set_detail_level( '7' )->get_all_values(
      IMPORTING
        detail_level = detail_level
        severity = severity
        id = id
        number = number
        variable_1 = variable_1
        variable_2 = variable_2
        variable_3 = variable_3
        variable_4 = variable_4 ).

    cl_abap_unit_assert=>assert_equals( act = detail_level exp = '7' ).
    cl_abap_unit_assert=>assert_equals( act = severity exp = 'W' ).
    cl_abap_unit_assert=>assert_equals( act = id exp = '00' ).
    cl_abap_unit_assert=>assert_equals( act = number exp = '001' ).
    cl_abap_unit_assert=>assert_equals( act = variable_1 exp = 'first' ).
  ENDMETHOD.

  METHOD create_message_from_bapiret2.
    DATA message_data TYPE bapiret2.
    DATA severity TYPE if_bali_item_setter=>ty_severity.
    DATA id TYPE if_bali_message_setter=>ty_id.
    DATA number TYPE if_bali_message_setter=>ty_number.
    DATA variable_1 TYPE if_bali_message_setter=>ty_variable.

    message_data-type = 'E'.
    message_data-id = 'ZTEST'.
    message_data-number = '123'.
    message_data-message_v1 = 'value'.

    DATA(message) = cl_bali_message_setter=>create_from_bapiret2( message_data ).
    message->get_all_values(
      IMPORTING
        severity = severity
        id = id
        number = number
        variable_1 = variable_1 ).

    cl_abap_unit_assert=>assert_equals( act = severity exp = 'E' ).
    cl_abap_unit_assert=>assert_equals( act = id exp = 'ZTEST' ).
    cl_abap_unit_assert=>assert_equals( act = number exp = '123' ).
    cl_abap_unit_assert=>assert_equals( act = variable_1 exp = 'value' ).
  ENDMETHOD.

  METHOD create_exception.
    DATA detail_level TYPE if_bali_item_setter=>ty_detail_level.
    DATA severity TYPE if_bali_item_setter=>ty_severity.
    DATA returned_exception TYPE REF TO cx_root.
    DATA source_exception TYPE REF TO cx_bali_runtime.

    CREATE OBJECT source_exception.
    DATA(exception_item) = cl_bali_exception_setter=>create(
      severity = if_bali_constants=>c_severity_error
      exception = source_exception ).

    exception_item->set_detail_level( '8' )->get_all_values(
      IMPORTING
        detail_level = detail_level
        severity = severity
        exception = returned_exception ).

    cl_abap_unit_assert=>assert_equals( act = detail_level exp = '8' ).
    cl_abap_unit_assert=>assert_equals( act = severity exp = 'E' ).
    cl_abap_unit_assert=>assert_bound( returned_exception ).
    cl_abap_unit_assert=>assert_equals( act = returned_exception exp = source_exception ).
  ENDMETHOD.

  METHOD add_item.
    DATA(log) = cl_bali_log=>create( ).
    DATA(message) = cl_bali_message_setter=>create(
      id     = '00'
      number = '001' ).

    log->add_item( message ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( log->get_all_items( ) )
      exp = 1 ).
  ENDMETHOD.

  METHOD test1.

    DATA lv_loghndl    TYPE balloghndl.
    DATA lt_lognumbers TYPE bal_t_lgnm.
    DATA ls_header     TYPE bal_s_log.
    DATA ls_msg        TYPE bal_s_msg.
    DATA lt_handles    TYPE bal_t_logh.

    ls_header-object = 'ZFOOBAR'.

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = ls_header
      IMPORTING
        e_log_handle            = lv_loghndl
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( lv_loghndl ).

    ls_msg-msgty = sy-msgty.
    ls_msg-msgid = sy-msgid.
    ls_msg-msgno = sy-msgno.
    ls_msg-msgv1 = sy-msgv1.
    ls_msg-msgv2 = sy-msgv2.
    ls_msg-msgv3 = sy-msgv3.
    ls_msg-msgv4 = sy-msgv4.

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle     = lv_loghndl
        i_s_msg          = ls_msg
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        log_is_full      = 3
        OTHERS           = 4.
    cl_abap_unit_assert=>assert_subrc( ).

    APPEND lv_loghndl TO lt_handles.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle   = lt_handles
      IMPORTING
        e_new_lognumbers = lt_lognumbers
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( lt_lognumbers ).

  ENDMETHOD.

  METHOD display_profile_single_log.
    DATA ls_profile TYPE bal_s_prof.

    CALL FUNCTION 'BAL_DSP_PROFILE_SINGLE_LOG_GET'
      IMPORTING
        e_s_display_profile = ls_profile.

    cl_abap_unit_assert=>assert_not_initial( ls_profile-title ).
    cl_abap_unit_assert=>assert_equals( act = ls_profile-show_all exp = abap_true ).
    cl_abap_unit_assert=>assert_equals( act = lines( ls_profile-lev1_fcat ) exp = 1 ).
    cl_abap_unit_assert=>assert_not_initial( ls_profile-mess_fcat ).
  ENDMETHOD.

  METHOD log_filter_ranges.
    DATA ls_filter TYPE bal_s_lfil.

    INSERT VALUE #( sign = 'I' option = 'EQ' low = 'ZFOOBAR' ) INTO TABLE ls_filter-object.
    INSERT VALUE #( sign = 'I' option = 'BT' low = '20260101' high = '20261231' ) INTO TABLE ls_filter-aldate.

    cl_abap_unit_assert=>assert_equals( act = lines( ls_filter-object ) exp = 1 ).
    cl_abap_unit_assert=>assert_true( xsdbool( 'ZFOOBAR' IN ls_filter-object ) ).
    cl_abap_unit_assert=>assert_false( xsdbool( 'ZOTHER' IN ls_filter-object ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( CONV d( '20260615' ) IN ls_filter-aldate ) ).
    cl_abap_unit_assert=>assert_initial( ls_filter-subobject ).
  ENDMETHOD.

  METHOD get_header_values.
    DATA(log) = cl_bali_log=>create( ).
    DATA(setter) = cl_bali_header_setter=>create(
      object      = 'ZFOOBAR'
      subobject   = 'ZSUB'
      external_id = 'EXTERNAL' ).
    setter->set_expiry(
      expiry_date       = '20301231'
      keep_until_expiry = abap_true ).
    log->set_header( setter ).

    DATA(header) = log->get_header( ).

    cl_abap_unit_assert=>assert_equals( act = header->object exp = 'ZFOOBAR' ).
    cl_abap_unit_assert=>assert_equals( act = header->subobject exp = 'ZSUB' ).
    cl_abap_unit_assert=>assert_equals( act = header->external_id exp = 'EXTERNAL' ).
    cl_abap_unit_assert=>assert_equals( act = header->expiry_date exp = '20301231' ).
    cl_abap_unit_assert=>assert_equals( act = header->keep_until_expiry exp = abap_true ).
    cl_abap_unit_assert=>assert_equals( act = header->log_user exp = sy-uname ).
    cl_abap_unit_assert=>assert_not_initial( header->log_timestamp ).
  ENDMETHOD.

  METHOD get_header_without_header.
    DATA(header) = cl_bali_log=>create( )->get_header( ).

    cl_abap_unit_assert=>assert_bound( header ).
    cl_abap_unit_assert=>assert_initial( header->object ).
    cl_abap_unit_assert=>assert_equals( act = header->number_all_items exp = 0 ).
  ENDMETHOD.

  METHOD get_header_counts_items.
    DATA(log) = cl_bali_log=>create( ).

    log->add_item( cl_bali_free_text_setter=>create( severity = 'E' text = 'first error' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'E' text = 'second error' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'W' text = 'warning' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'I' text = 'information' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'S' text = 'status' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'A' text = 'abort' ) ).

    DATA(header) = log->get_header( ).

    cl_abap_unit_assert=>assert_equals( act = header->number_all_items exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = header->number_error_items exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = header->number_warning_items exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = header->number_information_items exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = header->number_status_items exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = header->number_abort_items exp = 1 ).
  ENDMETHOD.

  METHOD item_has_timestamp.
    DATA items TYPE if_bali_log=>ty_log_items.
    DATA item_line TYPE if_bali_log=>ty_log_item.
    DATA date TYPE d.
    DATA time TYPE t.

    DATA(log) = cl_bali_log=>create( ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'W' text = 'hello' ) ).

    items = log->get_all_items( ).
    READ TABLE items INDEX 1 INTO item_line.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( item_line-item->timestamp ).

    CONVERT UTCLONG item_line-item->timestamp INTO DATE date TIME time TIME ZONE 'UTC'.
    cl_abap_unit_assert=>assert_not_initial( date ).
  ENDMETHOD.

  METHOD message_item_exposes_key.
    DATA items TYPE if_bali_log=>ty_log_items.
    DATA item_line TYPE if_bali_log=>ty_log_item.
    DATA message TYPE REF TO if_bali_message_getter.

    DATA(log) = cl_bali_log=>create( ).
    log->add_item( cl_bali_message_setter=>create(
      severity   = if_bali_constants=>c_severity_error
      id         = 'ZTEST'
      number     = '123'
      variable_1 = 'one'
      variable_2 = 'two' ) ).

    items = log->get_all_items( ).
    READ TABLE items INDEX 1 INTO item_line.
    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_equals(
      act = item_line-item->category
      exp = if_bali_constants=>c_category_message ).

    message ?= item_line-item.
    cl_abap_unit_assert=>assert_equals( act = message->id exp = 'ZTEST' ).
    cl_abap_unit_assert=>assert_equals( act = message->number exp = '123' ).
    cl_abap_unit_assert=>assert_equals( act = message->variable_1 exp = 'one' ).
    cl_abap_unit_assert=>assert_equals( act = message->variable_2 exp = 'two' ).
    cl_abap_unit_assert=>assert_initial( message->variable_3 ).
    cl_abap_unit_assert=>assert_equals( act = message->severity exp = 'E' ).
    cl_abap_unit_assert=>assert_not_initial( message->timestamp ).
  ENDMETHOD.

  METHOD free_text_is_not_a_message.
    DATA items TYPE if_bali_log=>ty_log_items.
    DATA item_line TYPE if_bali_log=>ty_log_item.
    DATA message TYPE REF TO if_bali_message_getter.

    DATA(log) = cl_bali_log=>create( ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'W' text = 'hello' ) ).

    items = log->get_all_items( ).
    READ TABLE items INDEX 1 INTO item_line.
    cl_abap_unit_assert=>assert_subrc( ).

    TRY.
        message ?= item_line-item.
        cl_abap_unit_assert=>fail( ).
      CATCH cx_sy_move_cast_error.
        cl_abap_unit_assert=>assert_equals( act = item_line-item->get_message_text( ) exp = 'hello' ).
    ENDTRY.
  ENDMETHOD.

  METHOD load_saved_log_by_handle.
    DATA handle TYPE balloghndl.

    DATA(log) = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object = 'ZFOOBAR' ) ).
    log->add_item( cl_bali_free_text_setter=>create( severity = 'E' text = 'persisted' ) ).
    cl_bali_log_db=>get_instance( )->save_log( log ).
    handle = log->get_handle( ).

    DATA(loaded) = cl_bali_log_db=>get_instance( )->load_log( handle ).

    cl_abap_unit_assert=>assert_equals( act = loaded->get_handle( ) exp = handle ).
    cl_abap_unit_assert=>assert_equals( act = loaded->get_header( )->object exp = 'ZFOOBAR' ).
    cl_abap_unit_assert=>assert_equals( act = lines( loaded->get_all_items( ) ) exp = 1 ).
  ENDMETHOD.

  METHOD load_picks_log_by_handle.
    DATA(first) = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object = 'ZFIRST' ) ).
    DATA(second) = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object = 'ZSECOND' ) ).

    cl_bali_log_db=>get_instance( )->save_log( first ).
    cl_bali_log_db=>get_instance( )->save_log( second ).

    cl_abap_unit_assert=>assert_equals(
      act = cl_bali_log_db=>get_instance( )->load_log( first->get_handle( ) )->get_header( )->object
      exp = 'ZFIRST' ).
    cl_abap_unit_assert=>assert_equals(
      act = cl_bali_log_db=>get_instance( )->load_log( second->get_handle( ) )->get_header( )->object
      exp = 'ZSECOND' ).
  ENDMETHOD.

  METHOD load_unknown_handle_raises.
    TRY.
        cl_bali_log_db=>get_instance( )->load_log( 'NO_SUCH_HANDLE' ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_bali_not_found.
        RETURN.
      CATCH cx_bali_runtime.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD load_deleted_log_raises.
    DATA(log) = cl_bali_log=>create( ).

    cl_bali_log_db=>get_instance( )->save_log( log ).
    cl_bali_log_db=>get_instance( )->delete_log( log ).

    TRY.
        cl_bali_log_db=>get_instance( )->load_log( log->get_handle( ) ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_bali_runtime.
        RETURN.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_object_check DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS setup RAISING cx_sql_exception.
    METHODS teardown RAISING cx_sql_exception.
    METHODS execute_sql
      IMPORTING
        statement TYPE string
      RAISING
        cx_sql_exception.
    METHODS known_object_accepted FOR TESTING RAISING cx_bali_runtime.
    METHODS known_subobject_accepted FOR TESTING RAISING cx_bali_runtime.
    METHODS unknown_object_raises FOR TESTING.
    METHODS unknown_subobject_raises FOR TESTING.
    METHODS initial_object_accepted FOR TESTING RAISING cx_bali_runtime.
    METHODS no_objects_defined_accepts_all FOR TESTING RAISING cx_bali_runtime cx_sql_exception.

ENDCLASS.

CLASS ltcl_object_check IMPLEMENTATION.

  METHOD execute_sql.
* BALOBJ and BALSUB are filled through ADBC, the same way a consumer does it in its database setup
    DATA lo_statement TYPE REF TO cl_sql_statement.

    CREATE OBJECT lo_statement.
    lo_statement->execute_update( statement ).
  ENDMETHOD.

  METHOD setup.
    execute_sql( `INSERT INTO balobj (object) VALUES ('ZFOOBAR')` ).
    execute_sql( `INSERT INTO balsub (object, subobject) VALUES ('ZFOOBAR', 'ZSUB')` ).
  ENDMETHOD.

  METHOD teardown.
* the other tests run without any object defined
    execute_sql( `DELETE FROM balobj` ).
    execute_sql( `DELETE FROM balsub` ).
  ENDMETHOD.

  METHOD known_object_accepted.
    cl_abap_unit_assert=>assert_bound( cl_bali_header_setter=>create( object = 'ZFOOBAR' ) ).
  ENDMETHOD.

  METHOD known_subobject_accepted.
    cl_abap_unit_assert=>assert_bound( cl_bali_header_setter=>create(
      object    = 'ZFOOBAR'
      subobject = 'ZSUB' ) ).
  ENDMETHOD.

  METHOD unknown_object_raises.
    TRY.
        cl_bali_header_setter=>create( object = 'ZUNKNOWN' ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_bali_invalid_parameter.
        RETURN.
      CATCH cx_bali_runtime.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD unknown_subobject_raises.
    TRY.
        cl_bali_header_setter=>create(
          object    = 'ZFOOBAR'
          subobject = 'ZUNKNOWN' ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_bali_invalid_parameter.
        RETURN.
      CATCH cx_bali_runtime.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD initial_object_accepted.
    cl_abap_unit_assert=>assert_bound( cl_bali_header_setter=>create( object = '' ) ).
  ENDMETHOD.

  METHOD no_objects_defined_accepts_all.
    execute_sql( `DELETE FROM balobj` ).

    cl_abap_unit_assert=>assert_bound( cl_bali_header_setter=>create( object = 'ZUNKNOWN' ) ).
  ENDMETHOD.

ENDCLASS.
