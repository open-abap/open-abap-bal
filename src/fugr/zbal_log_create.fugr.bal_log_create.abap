FUNCTION bal_log_create.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_S_LOG) TYPE  BAL_S_LOG
*"  EXPORTING
*"     VALUE(E_LOG_HANDLE) TYPE  BALLOGHNDL
*"  EXCEPTIONS
*"      LOG_HEADER_INCONSISTENT
*"----------------------------------------------------------------------

  e_log_handle = '123'.

ENDFUNCTION.