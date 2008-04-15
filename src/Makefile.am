# Makefile.am for system-update/src

SUBDIRS=config

yncludedir = @yncludedir@/system-update

client_DATA =			\
	system-update.ycp	\
	inst_system_update_prepare_system.ycp	\
	inst_system_update_repo_select.ycp

module_DATA =			\
	SystemUpdate.ycp

ybin_SCRIPTS =			\
	system-update.sh

# create a symlink for local build, #145327
system-update:
	ln -sf . $@
ycpchook = system-update

EXTRA_DIST = $(client_DATA) $(ynclude_DATA) $(module_DATA) $(ybin_SCRIPTS)

include $(top_srcdir)/Makefile.am.common
