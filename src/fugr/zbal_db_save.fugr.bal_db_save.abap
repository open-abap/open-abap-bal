FUNCTION bal_db_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_T_LOG_HANDLE) TYPE  BAL_T_LOGH OPTIONAL
*"  EXPORTING
*"     VALUE(E_NEW_LOGNUMBERS) TYPE  BAL_T_LGNM
*"  EXCEPTIONS
*"      LOG_NOT_FOUND
*"      SAVE_NOT_ALLOWED
*"      NUMBERING_ERROR
*"----------------------------------------------------------------------

  FIELD-SYMBOLS <fs> LIKE LINE OF e_new_lognumbers.

* todo
  APPEND INITIAL LINE TO e_new_lognumbers ASSIGNING <fs>.
  <fs>-lognumber = '123'.

* workaround for exceptions,
  sy-subrc = 0.

ENDFUNCTION.