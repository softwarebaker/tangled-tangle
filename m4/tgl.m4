AC_DEFUN([TGL_ARG_VAR],
[
    AC_ARG_VAR([$1], [$2 (default=$3)])
    AM_CONDITIONAL([IS_SET], [test -n "${$1}"])
    AM_COND_IF([IS_SET], 
               [AC_SUBST($1)],       dnl $1 is passed to ./configure, e.g., ./configure BUILD_VERSION=1.0
               [AC_SUBST($1, $3)])   dnl $1 is not passed to ./configure, default will be used instead
])


AC_DEFUN([TGL_CHECK_PROG],
[
    dnl Result of AC_CHECK_PROG is cached into variable ac_cv_prog_%VAR_NAME%
    unset ac_cv_prog_RESULT
    AC_CHECK_PROG(RESULT, [$1 --version], [$1], [no])
    test "${RESULT}" == "no" && AC_MSG_ERROR([Required program $1 not found.])
    unset RESULT
])


AC_DEFUN([TGL_COMPARE_VERSION],
[
    AC_MSG_CHECKING([for version $1 $2 $3 $4])
    AX_COMPARE_VERSION([$2], [$3], [$4], 
                       [AC_MSG_RESULT([ok])], 
                       [AC_MSG_RESULT([fail]) 
                        AC_MSG_ERROR([$1 version mismatch])])
])