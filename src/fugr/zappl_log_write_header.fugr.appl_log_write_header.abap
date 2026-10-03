FUNCTION appl_log_write_header.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(HEADER) TYPE  BALHDRI
*"     REFERENCE(LOG_HANDLE) TYPE  BALLOGHNDL OPTIONAL
*"  EXPORTING
*"     REFERENCE(UPDATE_OR_INSERT) TYPE  CHAR1
*"     REFERENCE(E_LOG_HANDLE) TYPE  BALLOGHNDL
*"  EXCEPTIONS
*"      OBJECT_NOT_FOUND
*"      SUBOBJECT_NOT_FOUND
*"      ERROR
*"----------------------------------------------------------------------

  ASSERT 1 = 'todo'.

ENDFUNCTION.