CLASS cl_bali_exception_setter DEFINITION PUBLIC CREATE PRIVATE.
  PUBLIC SECTION.
    INTERFACES if_bali_item_setter.
    INTERFACES if_bali_exception_setter.

    CLASS-METHODS create
      IMPORTING
        severity             TYPE if_bali_item_setter=>ty_severity OPTIONAL
        exception            TYPE REF TO cx_root
      RETURNING
        VALUE(exception_obj) TYPE REF TO if_bali_exception_setter.

    METHODS constructor.

  PRIVATE SECTION.
    DATA exception_detail_level TYPE if_bali_item_setter=>ty_detail_level.
    DATA exception_severity TYPE if_bali_item_setter=>ty_severity.
    DATA exception_reference TYPE REF TO cx_root.

    METHODS normalize_severity
      IMPORTING
        severity      TYPE if_bali_item_setter=>ty_severity
      RETURNING
        VALUE(result) TYPE if_bali_item_setter=>ty_severity.
ENDCLASS.

CLASS cl_bali_exception_setter IMPLEMENTATION.
  METHOD constructor.
    exception_detail_level = '1'.
    exception_severity = if_bali_constants=>c_severity_status.
  ENDMETHOD.

  METHOD create.
    DATA setter TYPE REF TO cl_bali_exception_setter.
    CREATE OBJECT setter.
    exception_obj = setter->if_bali_exception_setter~set_exception(
      severity = severity
      exception = exception ).
  ENDMETHOD.

  METHOD if_bali_exception_setter~set_exception.
    exception_severity = normalize_severity( severity ).
    exception_reference = exception.
    new_exception_obj = me.
  ENDMETHOD.

  METHOD if_bali_exception_setter~set_detail_level.
    IF detail_level IS INITIAL OR
        ( detail_level >= '1' AND detail_level <= '9' ).
      exception_detail_level = detail_level.
    ELSE.
      exception_detail_level = '1'.
    ENDIF.
    new_exception_obj = me.
  ENDMETHOD.

  METHOD if_bali_exception_setter~get_all_values.
    detail_level = exception_detail_level.
    severity = exception_severity.
    exception = exception_reference.
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
