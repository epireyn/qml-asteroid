# Try to find mkcal-qt5
# Once done this will define
# mKCal_FOUND - System has mkcal
# mKCal_INCLUDE_DIRS - The mkcal include directories
# mKCal_LIBRARIES - The libraries needed to use mkcal
# mKCal_DEFINITIONS - Compiler switches required for using mkcal

find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_mKCal QUIET mkcal-qt5)
set(mKCal_DEFINITIONS ${PC_mKCal_CFLAGS_OTHER})

find_path(mKCal_INCLUDE_DIRS
	NAMES extendedcalendar.h
	PATH_SUFFIXES mkcal-qt5
	PATHS ${PC_mKCal_INCLUDEDIR} ${PC_mKCal_INCLUDE_DIRS})

find_library(mKCal_LIBRARIES
	NAMES mkcal-qt5
	PATHS ${PC_mKCal_LIBDIR} ${PC_mKCal_LIBRARY_DIRS})

set(mKCal_VERSION ${PC_mKCal_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(mKCal
	FOUND_VAR
		mKCal_FOUND
	REQUIRED_VARS
		mKCal_LIBRARIES
		mKCal_INCLUDE_DIRS
	VERSION_VAR
		mKCal_VERSION)

mark_as_advanced(mKCal_INCLUDE_DIR mKCal_LIBRARY mKCal_VERSION)

if(mKCal_FOUND AND NOT TARGET mKCal::mKCal)
	add_library(mKCal::mKCal UNKNOWN IMPORTED)
	set_target_properties(mKCal::mKCal PROPERTIES
		IMPORTED_LOCATION "${mKCal_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "${mKCal_INCLUDE_DIRS}")
endif()
