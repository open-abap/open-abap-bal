INTERFACE if_bali_constants PUBLIC.
  TYPES ty_category TYPE c LENGTH 1.
  TYPES ty_severity TYPE c LENGTH 1.

  CONSTANTS c_category_exception TYPE ty_category VALUE 'E'.
  CONSTANTS c_category_free_text TYPE ty_category VALUE 'F'.
  CONSTANTS c_category_message TYPE ty_category VALUE 'M'.
  CONSTANTS c_severity_error TYPE ty_severity VALUE 'E'.
  CONSTANTS c_severity_exit TYPE ty_severity VALUE 'X'.
  CONSTANTS c_severity_information TYPE ty_severity VALUE 'I'.
  CONSTANTS c_severity_status TYPE ty_severity VALUE 'S'.
  CONSTANTS c_severity_termination TYPE ty_severity VALUE 'A'.
  CONSTANTS c_severity_warning TYPE ty_severity VALUE 'W'.
ENDINTERFACE.
