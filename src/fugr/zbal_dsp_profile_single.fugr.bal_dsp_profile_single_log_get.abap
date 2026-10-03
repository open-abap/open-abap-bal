FUNCTION bal_dsp_profile_single_log_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(E_S_DISPLAY_PROFILE) TYPE  BAL_S_PROF
*"----------------------------------------------------------------------

  DATA ls_fcat TYPE bal_s_fcat.
  DATA ls_sort TYPE bal_s_sort.

  CLEAR e_s_display_profile.

  e_s_display_profile-title     = 'Application Log'.
  e_s_display_profile-head_text = 'Application Log'.
  e_s_display_profile-root_text = 'Problem Classes'.
  e_s_display_profile-show_all  = abap_true.
  e_s_display_profile-tree_size = 22.

* tree, level 1: problem class
  ls_fcat-ref_table = 'BAL_S_SHOW'.
  ls_fcat-ref_field = 'PROBCLASS'.
  ls_fcat-outputlen = 20.
  APPEND ls_fcat TO e_s_display_profile-lev1_fcat.

  ls_sort-ref_table = 'BAL_S_SHOW'.
  ls_sort-ref_field = 'PROBCLASS'.
  ls_sort-up        = abap_true.
  APPEND ls_sort TO e_s_display_profile-lev1_sort.

* message list
  CLEAR ls_fcat.
  ls_fcat-ref_table = 'BAL_S_SHOW'.
  ls_fcat-ref_field = 'T_MSG'.
  ls_fcat-col_pos   = 1.
  ls_fcat-outputlen = 100.
  APPEND ls_fcat TO e_s_display_profile-mess_fcat.

  CLEAR ls_fcat.
  ls_fcat-ref_table = 'BAL_S_SHOW'.
  ls_fcat-ref_field = 'MSGID'.
  ls_fcat-col_pos   = 2.
  ls_fcat-no_out    = abap_true.
  APPEND ls_fcat TO e_s_display_profile-mess_fcat.

  CLEAR ls_fcat.
  ls_fcat-ref_table = 'BAL_S_SHOW'.
  ls_fcat-ref_field = 'MSGNO'.
  ls_fcat-col_pos   = 3.
  ls_fcat-no_out    = abap_true.
  APPEND ls_fcat TO e_s_display_profile-mess_fcat.

ENDFUNCTION.
