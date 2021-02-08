project(spacebar CXX)

cmake_minimum_required(VERSION 2.8.9)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/")
find_package(CommonModules REQUIRED)

#################################################################################################
# Modify these variables to what suits the application best. Remember, no dashes in the version!
set(SPACEBAR_MAJOR_VERSION 0)
set(SPACEBAR_MINOR_VERSION 1)
set(SPACEBAR_RELEASE_VERSION 2)

option(SPACEBAR_DEVELOPMENT_RELEASE "Must be ON unless we're releasing" ON)
option(ENABLE_WERROR "Enables WError. Always enable when developing, and disable when releasing." ON)

#################################################################################################

set(SPACEBAR_VERSION ${SPACEBAR_MAJOR_VERSION}.${SPACEBAR_MINOR_VERSION}.${SPACEBAR_RELEASE_VERSION})
if (SPACEBAR_DEVELOPMENT_RELEASE)
    include(GetGitRevisionDescription)
    get_git_head_revision(GIT_REFSPEC GIT_SHA1)
    STRING(SUBSTRING ${GIT_SHA1} 0 8 GIT_SHA1_SMALL)
    set(SPACEBAR_VERSION_STRING ${SPACEBAR_MAJOR_VERSION}.${SPACEBAR_MINOR_VERSION}.${SPACEBAR_RELEASE_VERSION}+git${GIT_SHA1_SMALL})

    # Enable debug messages
    add_definitions(-DDEBUG_MESSAGES_DEFAULT_LEVEL=QtDebugMsg)
else (SPACEBAR_DEVELOPMENT_RELEASE)
    set(SPACEBAR_VERSION_STRING ${SPACEBAR_MAJOR_VERSION}.${SPACEBAR_MINOR_VERSION}.${SPACEBAR_RELEASE_VERSION})

    # Show only warning messages and worst
    add_definitions(-DDEBUG_MESSAGES_DEFAULT_LEVEL=QtWarningMsg)
endif (SPACEBAR_DEVELOPMENT_RELEASE)

find_package(Qt5 COMPONENTS Core Qml Quick Network REQUIRED)
# We need additional private headers
include_directories(${Qt5Gui_PRIVATE_INCLUDE_DIRS} ${Qt5Quick_PRIVATE_INCLUDE_DIRS} )

add_definitions(-DSPACEBAR_VERSION="${SPACEBAR_VERSION_STRING}")

set(CMAKE_AUTOMOC TRUE)
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)

include(EnableCoverageReport)
include(EnableSlocCount)
include(GenerateCppcheck)
include(GitArchive)
include(CompilerWarnings)
include(TestCXXAcceptsFlag)

# Warnings. Enable WError, this component is critical.
if(${ENABLE_WERROR})
    set(RET_W 1)
else(${ENABLE_WERROR})
    set(RET_W 0)
endif(${ENABLE_WERROR})

set(desired
    all
    extra
    sign-compare
    pointer-arith
    format-security
    init-self
    non-virtual-dtor)
set(undesired
    missing-field-initializers
    unused-parameter)
compiler_warnings(CMAKE_CXX_FLAGS_WARNINGS cxx ${RET_W} "${desired}" "${undesired}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_WARNINGS}")

# C++11
if (CMAKE_COMPILER_IS_GNUCXX)
   execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
   if (GCC_VERSION VERSION_GREATER 4.7 OR GCC_VERSION VERSION_EQUAL 4.7)
        message(STATUS "C++11 activated.")
        add_definitions("-std=gnu++11")
   elseif (GCC_VERSION VERSION_GREATER 4.3 OR GCC_VERSION VERSION_EQUAL 4.3)
        message(WARNING "C++0x activated. If you get any errors update to a compiler which fully supports C++11")
        add_definitions("-std=gnu++0x")
   else ()
        message(FATAL_ERROR "C++11 needed. Therefore a gcc compiler with a version higher than 4.3 is needed.")
   endif()
else (CMAKE_COMPILER_IS_GNUCXX)
   add_definitions("-std=c++0x")
endif (CMAKE_COMPILER_IS_GNUCXX)

# We want explicit literals all over the place, and fast concat
#add_definitions(-DQT_NO_CAST_FROM_ASCII -DQT_USE_QSTRINGBUILDER)

# Offer the user the choice of overriding the installation directories
set(INSTALL_LIB_DIR lib CACHE PATH "Installation directory for libraries")
set(INSTALL_BIN_DIR libexec/hemera CACHE PATH "Installation directory for executables")
set(INSTALL_INCLUDE_DIR include CACHE PATH "Installation directory for header files")
set(INSTALL_QML_IMPORTS_DIR ${INSTALL_LIB_DIR}/qt5/qml CACHE PATH "Installation directory for QML import plugins")
set(INSTALL_INPUTCONTEXT_PLUGINS_DIR ${INSTALL_LIB_DIR}/qt5/plugins/platforminputcontexts CACHE PATH "Installation directory for QML import plugins")

# Make relative paths absolute (needed later on)
foreach(p LIB BIN INCLUDE QML_IMPORTS INPUTCONTEXT_PLUGINS)
  set(var INSTALL_${p}_DIR)
  if(NOT IS_ABSOLUTE "${${var}}")
    set(${var} "${CMAKE_INSTALL_PREFIX}/${${var}}")
  endif()
endforeach()

# Enable compilation of tests and examples by default only if we're not in a submodule
if (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
    option(ENABLE_SPACEBAR_EXAMPLES "Enable compilation of examples" ON)
    option(ENABLE_SPACEBAR_TESTS "Enable compilation of tests" ON)
else (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
    option(ENABLE_SPACEBAR_EXAMPLES "Enable compilation of examples" OFF)
    option(ENABLE_SPACEBAR_TESTS "Enable compilation of tests" OFF)
endif (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})

option(ENABLE_SPACEBAR_COVERAGE "Enable compiler coverage" OFF)

# Definitions
add_definitions(-DSPACEBAR_VERSION="${SPACEBAR_VERSION_STRING}")

# sources
add_subdirectory(images)
add_subdirectory(quickkeyboard)

if (ENABLE_SPACEBAR_EXAMPLES)
#     add_subdirectory(testApp)
endif (ENABLE_SPACEBAR_EXAMPLES)

if (ENABLE_SPACEBAR_TESTS)
    enable_testing()
    #add_subdirectory(tests)
endif (ENABLE_SPACEBAR_TESTS)

# Add these targets only if we are in the root dir
if (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
    # --- sloccount ---

    enable_sloccount(FOLDERS src testApp)

    # --- cppcheck ---

    generate_cppcheck(SOURCES src testApp
                      ENABLE_IDS all
                      INLINE_SUPPRESSION)

    # --- coverage ---

    if (ENABLE_SPACEBAR_COVERAGE)
        #enable_coverage_report(TARGETS Socializer
        #                       TESTS   socializer-test
        #                       FILTER "tests/* src/*")
        #add_definitions(-fprofile-arcs -ftest-coverage)
    endif (ENABLE_SPACEBAR_COVERAGE)
endif (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})

# Archive
add_make_dist_target(spacebar ${SPACEBAR_VERSION_STRING})

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
