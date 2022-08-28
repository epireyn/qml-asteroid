# Try to find kcalcoren
# Once done this will define
# KCalCoren_FOUND - System has kcalcoren
# KCalCoren_INCLUDE_DIRS - The kcalcoren include directories
# KCalCoren_LIBRARIES - The libraries needed to use kcalcoren
# KCalCoren_DEFINITIONS - Compiler switches required for using kcalcoren

find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_KCalCoren QUIET kcalcoren)
set(KCalCoren_DEFINITIONS ${PC_KCalCoren_CFLAGS_OTHER})

find_path(KCalCoren_INCLUDE_DIRS
	NAMES global.h
	PATH_SUFFIXES kcalcoren-qt5
	PATHS ${PC_KCalCoren_INCLUDEDIR} ${PC_KCalCoren_INCLUDE_DIRS})

find_library(KCalCoren_LIBRARIES
	NAMES kcalcoren-qt5
	PATHS ${PC_KCalCoren_LIBDIR} ${PC_KCalCoren_LIBRARY_DIRS})

set(KCalCoren_VERSION ${PC_KCalCoren_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(KCalCoren
	FOUND_VAR
		KCalCoren_FOUND
	REQUIRED_VARS
		KCalCoren_LIBRARIES
		KCalCoren_INCLUDE_DIRS
	VERSION_VAR
		KCalCoren_VERSION)

mark_as_advanced(KCalCoren_INCLUDE_DIR KCalCoren_LIBRARY KCalCoren_VERSION)

if(KCalCoren_FOUND AND NOT TARGET KCalCoren::KCalCoren)
	add_library(KCalCoren::KCalCoren UNKNOWN IMPORTED)
	set_target_properties(KCalCoren::KCalCoren PROPERTIES
		IMPORTED_LOCATION "${KCalCoren_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "${KCalCoren_INCLUDE_DIRS}")
endif()
