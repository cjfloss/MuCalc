project (mu_calculator)

cmake_minimum_required (VERSION 2.6)
cmake_policy (VERSION 2.8)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
enable_testing ()

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/mu_calculator")
set (GETTEXT_PACKAGE "mu_calculator")
set (RELEASE_NAME "Mu")
set (VERSION "0.1")
set (VERSION_INFO "Release")
set (CMAKE_C_FLAGS "-ggdb")
set (PREFIX ${CMAKE_INSTALL_PREFIX})

configure_file (${CMAKE_SOURCE_DIR}/src/Config.vala.cmake ${CMAKE_BINARY_DIR}/src/Config.vala)

add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.16.0" MINIMUM)

include(ValaPrecompile)

vala_precompile(VALA_C
	src/main.vala
	src/main_window.vala
	src/Widgets/graph.vala
PACKAGES
	granite
OPTIONS
	-X -O2
)

add_subdirectory (po)

add_executable(mu_calculator ${VALA_C})

install(TARGETS mu_calculator RUNTIME DESTINATION bin)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/Mu.desktop DESTINATION share/applications)

#icons for later
#install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/application_mu.svg DESTINATION share/icons/hicolor/48x48/apps)




