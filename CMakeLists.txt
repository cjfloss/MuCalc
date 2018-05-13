project (mu_calculator)

cmake_minimum_required (VERSION 2.6)
cmake_policy (VERSION 2.8)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
enable_testing ()

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/pi_calculator")
set (GETTEXT_PACKAGE "pi_calculator")
set (RELEASE_NAME "Pi")
set (VERSION "0.1")
set (VERSION_INFO "Release")
set (CMAKE_C_FLAGS "-ggdb -lm")
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
	src/Math/2dgraph.vala
	src/Math/function.vala
	src/Math/point.vala
	src/Math/variable.vala
	src/Math/expression.vala
	src/Math/term.vala
	src/Math/math.vala
PACKAGES
	granite
OPTIONS
	-X -O2
)

add_subdirectory (po)

add_executable(pi_calculator ${VALA_C})

install(TARGETS pi_calculator RUNTIME DESTINATION bin)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/Pi.desktop DESTINATION share/applications)

#icons for later
#install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/3d_graph_icon.svg DESTINATION share/icons/hicolor/scalable/actions)
#install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/2d_graph_icon.svg DESTINATION share/icons/hicolor/scalable/actions)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/256/application-pi-calc.png DESTINATION share/icons/hicolor/256x256/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/192/application-pi-calc.png DESTINATION share/icons/hicolor/192x192/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/128/application-pi-calc.png DESTINATION share/icons/hicolor/128x128/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/96/application-pi-calc.png DESTINATION share/icons/hicolor/96x96/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/72/application-pi-calc.png DESTINATION share/icons/hicolor/72x72/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/64/application-pi-calc.png DESTINATION share/icons/hicolor/64x64/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/48/application-pi-calc.png DESTINATION share/icons/hicolor/48x48/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/32/application-pi-calc.png DESTINATION share/icons/hicolor/32x32/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/24/application-pi-calc.png DESTINATION share/icons/hicolor/24x24/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/22/application-pi-calc.png DESTINATION share/icons/hicolor/22x22/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/16/application-pi-calc.png DESTINATION share/icons/hicolor/16x16/apps)
