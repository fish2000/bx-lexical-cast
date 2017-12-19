cmake_minimum_required(VERSION 3.8.0)
project(LEXICAL_CAST LANGUAGES C CXX)

# the root directory name to use when installing:
set(installation_directory "bx-lexical-cast")

# add the interface-type library target “LEXICAL_CAST”:
add_library(LEXICAL_CAST INTERFACE)

# determine whether this is a standalone project,
# or one that has been included by other projects:
set(LEXICAL_CAST_STANDALONE_PROJECT OFF)
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(LEXICAL_CAST_STANDALONE_PROJECT ON)
endif()

if(CMAKE_MAJOR_VERSION VERSION_LESS 3.7.9)
    if(NOT MSVC)
        include(CheckCXXCompilerFlag)
        CHECK_CXX_COMPILER_FLAG("-std=c++17" COMPILER_SUPPORTS_CXX17)
        CHECK_CXX_COMPILER_FLAG("-std=c++14" COMPILER_SUPPORTS_CXX14)
        CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
        if(COMPILER_SUPPORTS_CXX17)
            target_compile_options(LEXICAL_CAST INTERFACE "-std=c++17")
        elseif(COMPILER_SUPPORTS_CXX14)
            target_compile_options(LEXICAL_CAST INTERFACE "-std=c++14")
        elseif(COMPILER_SUPPORTS_CXX11)
            target_compile_options(LEXICAL_CAST INTERFACE "-std=c++11")
        else()
            message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} lacks support for C++17/C++14/C++11")
        endif()
    else()
        # add definitions to the library and targets that consume it:
        target_compile_definitions(LEXICAL_CAST INTERFACE
            # remove unnecessary warnings about unchecked iterators
            $<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>)
    endif()
else()
    # set the LEXICAL_CAST library to optimally be compiled with c++14:
    target_compile_features(LEXICAL_CAST INTERFACE cxx_std_14)
    # on *nix, force the use of `-std=c++XX` flags (instead of defaulting to `-std=gnu++XX`):
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

# add include folders to the library and targets that consume it:
target_include_directories(LEXICAL_CAST INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)

# install the “boost” subdirectory in entirety:
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/boost/
        DESTINATION include/${installation_directory}/boost)

# include the “install_symlink(…)” macro:
set(cmake_directory ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(CMAKE_MODULE_PATH ${cmake_directory})
include(install_symlink)

# install the “lexical_cast” include-file symlink, in the proper place:
install_symlink(${CMAKE_INSTALL_PREFIX}/include/${installation_directory}/boost/lexical_cast.hpp
                ${CMAKE_INSTALL_PREFIX}/include/${installation_directory}/lexical_cast)
