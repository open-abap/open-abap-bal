CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test1.
    cl_abap_unit_assert=>assert_equals(
      act = 1
      exp = 2 ).
  ENDMETHOD.

ENDCLASS.