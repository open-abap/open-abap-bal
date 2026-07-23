CLASS cl_bali_message_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    INTERFACES if_bali_item_setter.
    INTERFACES if_bali_message_setter.

    CLASS-METHODS create
      IMPORTING
        severity       TYPE if_bali_item_setter=>ty_severity OPTIONAL
        id             TYPE if_bali_message_setter=>ty_id
        number         TYPE if_bali_message_setter=>ty_number
        variable_1     TYPE if_bali_message_setter=>ty_variable OPTIONAL
        variable_2     TYPE if_bali_message_setter=>ty_variable OPTIONAL
        variable_3     TYPE if_bali_message_setter=>ty_variable OPTIONAL
        variable_4     TYPE if_bali_message_setter=>ty_variable OPTIONAL
      RETURNING
        VALUE(message) TYPE REF TO if_bali_message_setter.

    CLASS-METHODS create_from_sy
      RETURNING
        VALUE(message) TYPE REF TO if_bali_message_setter.

    CLASS-METHODS create_from_bapiret2
      IMPORTING
        message_data   TYPE bapiret2
      RETURNING
        VALUE(message) TYPE REF TO if_bali_message_setter.

    METHODS constructor.

  PRIVATE SECTION.
    DATA message_detail_level TYPE if_bali_item_setter=>ty_detail_level.
    DATA message_severity TYPE if_bali_item_setter=>ty_severity.
    DATA message_id TYPE if_bali_message_setter=>ty_id.
    DATA message_number TYPE if_bali_message_setter=>ty_number.
    DATA message_variable_1 TYPE if_bali_message_setter=>ty_variable.
    DATA message_variable_2 TYPE if_bali_message_setter=>ty_variable.
    DATA message_variable_3 TYPE if_bali_message_setter=>ty_variable.
    DATA message_variable_4 TYPE if_bali_message_setter=>ty_variable.

    METHODS normalize_severity
      IMPORTING
        severity      TYPE if_bali_item_setter=>ty_severity
      RETURNING
        VALUE(result) TYPE if_bali_item_setter=>ty_severity.
ENDCLASS.

CLASS cl_bali_message_setter IMPLEMENTATION.
  METHOD constructor.
    message_detail_level = '1'.
    message_severity = if_bali_constants=>c_severity_status.
  ENDMETHOD.

  METHOD create.
    DATA setter TYPE REF TO cl_bali_message_setter.
    CREATE OBJECT setter.
    message = setter->if_bali_message_setter~set_attributes(
      severity = severity
      id = id
      number = number
      variable_1 = variable_1
      variable_2 = variable_2
      variable_3 = variable_3
      variable_4 = variable_4 ).
  ENDMETHOD.

  METHOD create_from_sy.
    DATA setter TYPE REF TO cl_bali_message_setter.
    CREATE OBJECT setter.
    message = setter->if_bali_message_setter~set_from_sy( ).
  ENDMETHOD.

  METHOD create_from_bapiret2.
    DATA setter TYPE REF TO cl_bali_message_setter.
    CREATE OBJECT setter.
    message = setter->if_bali_message_setter~set_from_bapiret2( message_data ).
  ENDMETHOD.

  METHOD if_bali_message_setter~set_attributes.
    message_severity = normalize_severity( severity ).
    message_id = id.
    message_number = number.
    message_variable_1 = variable_1.
    message_variable_2 = variable_2.
    message_variable_3 = variable_3.
    message_variable_4 = variable_4.
    new_message = me.
  ENDMETHOD.

  METHOD if_bali_message_setter~set_from_sy.
    message_severity = normalize_severity( sy-msgty ).
    message_id = sy-msgid.
    message_number = sy-msgno.
    message_variable_1 = sy-msgv1.
    message_variable_2 = sy-msgv2.
    message_variable_3 = sy-msgv3.
    message_variable_4 = sy-msgv4.
    new_message = me.
  ENDMETHOD.

  METHOD if_bali_message_setter~set_from_bapiret2.
    message_severity = normalize_severity( message_data-type ).
    message_id = message_data-id.
    message_number = message_data-number.
    message_variable_1 = message_data-message_v1.
    message_variable_2 = message_data-message_v2.
    message_variable_3 = message_data-message_v3.
    message_variable_4 = message_data-message_v4.
    new_message = me.
  ENDMETHOD.

  METHOD if_bali_message_setter~set_detail_level.
    IF detail_level IS INITIAL OR
        ( detail_level >= '1' AND detail_level <= '9' ).
      message_detail_level = detail_level.
    ELSE.
      message_detail_level = '1'.
    ENDIF.
    new_message = me.
  ENDMETHOD.

  METHOD if_bali_message_setter~get_all_values.
    detail_level = message_detail_level.
    severity = message_severity.
    id = message_id.
    number = message_number.
    variable_1 = message_variable_1.
    variable_2 = message_variable_2.
    variable_3 = message_variable_3.
    variable_4 = message_variable_4.
  ENDMETHOD.

  METHOD normalize_severity.
    CASE severity.
      WHEN if_bali_constants=>c_severity_error OR
          if_bali_constants=>c_severity_exit OR
          if_bali_constants=>c_severity_information OR
          if_bali_constants=>c_severity_status OR
          if_bali_constants=>c_severity_termination OR
          if_bali_constants=>c_severity_warning.
        result = severity.
      WHEN OTHERS.
        result = if_bali_constants=>c_severity_status.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
