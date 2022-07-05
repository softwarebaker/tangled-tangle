AC_INIT([tangled-tangle], [0.0.0])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([Cargo.toml])

########################################################################################################################
# MAKE ARTEFACTS
########################################################################################################################
TGL_ARG_VAR([ARTEFACTS], [top dir for artefacts], $(realpath ./.artefacts))

########################################################################################################################
# BUILD
########################################################################################################################
TGL_ARG_VAR([BUILD_BIN_NAME],    [executable file name], [tangled-tangle])
TGL_ARG_VAR([BUILD_MODE],        [build mode],           [debug])
TGL_ARG_VAR([BUILD_TARGET_ARCH], [build target arch],    [aarch64-apple-darwin])
TGL_ARG_VAR([BUILD_VERSION],     [build version],        [$(git rev-parse --short=10 HEAD)])

########################################################################################################################
# POSTGRESQL
########################################################################################################################
TGL_ARG_VAR([POSTGRES_AUTH_METHOD],        [postgeres auth method: { remote | peer | docker }], [remote])
TGL_ARG_VAR([POSTGRES_HOST],               [postgeres host],                                    [localhost])
TGL_ARG_VAR([POSTGRES_MAJOR_VERSION],      [postgeres major version],                           [12])
TGL_ARG_VAR([POSTGRES_PORT],               [postgeres port],                                    [5432])
TGL_ARG_VAR([POSTGRES_SUPERUSER_DB],       [postgeres superuser db],                            [postgres])
TGL_ARG_VAR([POSTGRES_SUPERUSER_PASSWORD], [postgeres superuser password],                      [postgres])
TGL_ARG_VAR([POSTGRES_SUPERUSER],          [postgeres superuser],                               [postgres])
TGL_ARG_VAR([POSTGRES_USER_DB],            [postgeres user db],                                 [tgl_db])
TGL_ARG_VAR([POSTGRES_USER_PASSWORD],      [postgeres user password],                           [12345])
TGL_ARG_VAR([POSTGRES_USER],               [postgeres user],                                    [tgl_api])

########################################################################################################################
# cargo
########################################################################################################################
m4_define([PROG], [cargo])
TGL_CHECK_PROG([PROG])

########################################################################################################################
# rustc
########################################################################################################################
m4_define([PROG], [rustc])
m4_define([PROG_REQUIRED_VERSION], [1.58.1])
m4_define([PROG_ACTUAL_VERSION], [$(echo $(PROG --version) | grep -oE "[[0-9]]\.[[0-9]]+\.[[0-9]]+")])

TGL_CHECK_PROG([PROG])
TGL_COMPARE_VERSION([PROG], [PROG_ACTUAL_VERSION], [eq], [PROG_REQUIRED_VERSION])

########################################################################################################################
# sqlx-cli
########################################################################################################################
m4_define([PROG], [sqlx])
m4_define([PROG_REQUIRED_VERSION], [0.5.10])
m4_define([PROG_ACTUAL_VERSION], [$(echo $(PROG --version) | grep -oE "[[0-9]]\.[[0-9]]+\.[[0-9]]+")])

AC_ARG_ENABLE([PROG],
              m4_expand([AS_HELP_STRING([--disable-[]PROG], [Skip ]PROG)]),
              [enable=false],
              [enable=true])

AM_CONDITIONAL([ENABLE], [test $enable = true])

AM_COND_IF([ENABLE],
           [TGL_CHECK_PROG([PROG])
            TGL_COMPARE_VERSION([PROG], [PROG_ACTUAL_VERSION], [ge], [PROG_REQUIRED_VERSION])])

########################################################################################################################
# psql
########################################################################################################################
m4_define([PROG], [psql])
m4_define([PROG_REQUIRED_VERSION], [$POSTGRES_MAJOR_VERSION])
m4_define([PROG_ACTUAL_VERSION], [$(echo $(PROG -V) | grep -oE "[[0-9]]+\.[[0-9]]+")])

AC_ARG_ENABLE([PROG],
              m4_expand([AS_HELP_STRING([--disable-[]PROG], [Skip ]PROG)]),
              [enable=false],
              [enable=true])

AM_CONDITIONAL([ENABLE], [test $enable = true])

AM_COND_IF([ENABLE],
           [TGL_CHECK_PROG([PROG])
            TGL_COMPARE_VERSION([PROG], [PROG_ACTUAL_VERSION], [ge], [PROG_REQUIRED_VERSION])])

########################################################################################################################
# LOG SEVERITIES
########################################################################################################################
TGL_ARG_VAR([LOG_SEVERITY_DEFAULT], [default log severity level], [debug])
TGL_ARG_VAR([LOG_SEVERITY_ACTIX_WEB], [log severity level for Actix web], [debug])
TGL_ARG_VAR([LOG_SEVERITY_ACTIX], [log severity level for Actix], [debug])
TGL_ARG_VAR([LOG_SEVERITY_SQLX], [log severity level for sqlx], [debug])

########################################################################################################################

AC_CONFIG_FILES([src/config_h.rs])
AC_CONFIG_FILES([Makefile])

AC_OUTPUT