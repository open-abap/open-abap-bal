FUNCTION bal_log_msg_add.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_LOG_HANDLE) TYPE  BALLOGHNDL OPTIONAL
*"     REFERENCE(I_S_MSG) TYPE  BAL_S_MSG
*"  EXCEPTIONS
*"      LOG_NOT_FOUND
*"      MSG_INCONSISTENT
*"      LOG_IS_FULL
*"----------------------------------------------------------------------

* todo

* workaround for exceptions,
  sy-subrc = 0.

ENDFUNCTION.