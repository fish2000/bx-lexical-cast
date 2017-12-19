# 
# install_symlink.cmake
# Adapted from https://github.com/bro/cmake/blob/master/InstallSymlink.cmake
#
# This macro can be used to install symlinks, which turns out to be
# non-trivial due to CMake version differences and limitations on how
# files can be installed when building binary packages.
#
# The rule for binary packaging is that files (including symlinks) must
# be installed with the standard CMake install() macro.
#
# The rule for non-binary packaging is that CMake 2.6 cannot install()
# symlinks, but can create the symlink at install-time via scripting.
# Though, we assume that CMake 2.6 isn't going to be used to generate
# packages because versions later than 2.8.3 are superior for that purpose.
#
#   _filepath: the absolute path to the file to symlink
#   _sympath: absolute path of the installed symlink

macro(install_symlink _filepath _sympath)
    
    get_filename_component(_symname ${_sympath} NAME)
    get_filename_component(_installdir ${_sympath} DIRECTORY)
    file(RELATIVE_PATH _relativeinstallpath ${_installdir} ${_installdir}/${_symname})
    get_filename_component(_relativeinstalldir ${_relativeinstallpath} DIRECTORY)
    
    get_filename_component(_filename ${_filepath} NAME)
    get_filename_component(_basedir ${_filepath} DIRECTORY)
    file(RELATIVE_PATH _relativefilepath ${_installdir} ${_basedir}/${_filename})
    
    if(BINARY_PACKAGING_MODE)
        execute_process(COMMAND "${CMAKE_COMMAND}" -E create_symlink
                        ${_relativefilepath}
                        ${CMAKE_CURRENT_BINARY_DIR}/${_symname})
        install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${_symname}
                DESTINATION ${_relativeinstalldir})
    else()
        # scripting the symlink installation at install time should work
        # for CMake 2.6.x and 2.8.x
        install(CODE "
            if(\"\$ENV{DESTDIR}\" STREQUAL \"\")
                execute_process(COMMAND \"${CMAKE_COMMAND}\" -E create_symlink
                                ${_relativefilepath}
                                ${_installdir}/${_relativeinstallpath})
            else()
                execute_process(COMMAND \"${CMAKE_COMMAND}\" -E create_symlink
                                ${_relativefilepath}
                                \$ENV{DESTDIR}/${_installdir}/${_relativeinstallpath})
            endif()
        ")
    endif()
    
endmacro(install_symlink)