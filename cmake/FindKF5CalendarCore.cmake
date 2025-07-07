# Try to find KF5CalendarCore
# Once done this will define
# KCalCoren_FOUND - System has kcalcoren
# KCalCoren_INCLUDE_DIRS - The kcalcoren include directories
# KCalCoren_LIBRARIES - The libraries needed to use kcalcoren
# KCalCoren_DEFINITIONS - Compiler switches required for using kcalcoren

find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_KF5CalendarCore QUIET KF5CalendarCore)
set(KF5CalendarCore_DEFINITIONS ${PC_KF5CalendarCore_CFLAGS_OTHER})

find_path(KF5CalendarCore_INCLUDE_DIRS
	NAMES calendar.h
	PATH_SUFFIXES kcalcore
	PATHS ${PC_KF5CalendarCore_INCLUDEDIR} ${PC_KF5CalendarCore_INCLUDE_DIRS})

find_library(KF5CalendarCore_LIBRARIES
	NAMES KF5CalendarCore
	PATHS ${PC_KF5CalendarCore_LIBDIR} ${PC_KF5CalendarCore_LIBRARY_DIRS})

set(KF5CalendarCore_VERSION ${PC_KF5CalendarCore_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(KF5CalendarCore
	FOUND_VAR
		KF5CalendarCore_FOUND
	REQUIRED_VARS
		KF5CalendarCore_LIBRARIES
		KF5CalendarCore_INCLUDE_DIRS
	VERSION_VAR
		KF5CalendarCore_VERSION)

mark_as_advanced(KF5CalendarCore_INCLUDE_DIR KF5CalendarCore_LIBRARY KF5CalendarCore_VERSION)

if(KF5CalendarCore_FOUND AND NOT TARGET KCalendarCore::KCalendarCore)
	add_library(KCalendarCore::KCalendarCore UNKNOWN IMPORTED)
	set_target_properties(KCalendarCore::KCalendarCore PROPERTIES
		IMPORTED_LOCATION "${KF5CalendarCore_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "${KF5CalendarCore_INCLUDE_DIRS}")
endif()
