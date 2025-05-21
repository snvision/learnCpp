include_guard(GLOBAL)


macro(chc_assert_not_str_empty var)
  if("${${var}}" STREQUAL "")
    message(FATAL_ERROR "Assert variable '${var}' is empty string.")
  endif()
endmacro()


macro(chc_assert_not_variable var)
  if(NOT ${var})
    message(FATAL_ERROR "Assert variable '${var}' is false.")
  endif()
endmacro()


function(chc_doxygen_gen target)
  find_program(doxygen_exe doxygen REQUIRED)
  get_target_property(src_dir ${target} SOURCE_DIR)
  get_target_property(bin_dir ${target} BINARY_DIR)
  get_target_property(sources ${target} SOURCES)
  set(out_docs_dir "${src_dir}/docs")
  set(doxygen_param_file_name "doxygen_parameters.txt")

  cmake_path(SET doxygen_param_file_cfg "${PROJECT_BINARY_DIR}/${doxygen_param_file_name}.in")
  if(NOT EXISTS "${doxygen_param_file_cfg}")
    set(doxygen_param
      "PROJECT_NAME = @project_name_placeholder@"
      "OUTPUT_DIRECTORY = \"@output_directory_placeholder@\""
      "INPUT = \"@input_placeholder@\""
      "EXCLUDE = @exclude_placeholder@"
      "RECURSIVE = YES"
      "EXTRACT_STATIC = YES"
      "EXTRACT_PRIVATE = YES"
      "EXTRACT_ALL = YES"
      "QUIET = YES"
      "GENERATE_LATEX = NO"
    )
    list(TRANSFORM doxygen_param APPEND "\n")
    string(REPLACE ";" "" doxygen_param "${doxygen_param}")
    file(WRITE "${doxygen_param_file_cfg}" "${doxygen_param}")
  endif()

  set(project_name_placeholder ${target})
  set(output_directory_placeholder "${out_docs_dir}")
  set(input_placeholder "${src_dir}")
  set(exclude_placeholder "${out_docs_dir}" "${src_dir}/readme.md")
  list(TRANSFORM exclude_placeholder PREPEND "\"")
  list(TRANSFORM exclude_placeholder APPEND "\"")
  string(REPLACE ";" " " exclude_placeholder "${exclude_placeholder}")
  cmake_path(SET doxygen_param_file "${bin_dir}/${doxygen_param_file_name}")
  configure_file("${doxygen_param_file_cfg}" "${doxygen_param_file}" @ONLY)

  set(index_file "${out_docs_dir}/html/index.html")
  cmake_path(SET doxygen_param_file_copied "${out_docs_dir}/${doxygen_param_file_name}")
  add_custom_command(
    COMMAND "${CMAKE_COMMAND}" -E copy "${doxygen_param_file}" "${doxygen_param_file_copied}"
    COMMAND "${CMAKE_COMMAND}" -E cat "${doxygen_param_file_copied}" | "${doxygen_exe}" -
    WORKING_DIRECTORY "${bin_dir}"
    OUTPUT "${index_file}"
    DEPENDS "${doxygen_param_file}" ${sources}
    COMMAND_EXPAND_LISTS
    VERBATIM
  )
  add_custom_target(${target}_doxygen
    DEPENDS "${index_file}"
  )

  find_program(firefox_bin firefox)
  if(NOT firefox_bin-NOTFOUND)
    cmake_path(SET profile_dir "${bin_dir}/doxygen/firefox_profile")
    add_custom_target(${target}_doxygen_show
      COMMAND "${CMAKE_COMMAND}" -E make_directory "${profile_dir}"
      COMMAND "${firefox_bin}" -profile "${profile_dir}" -no-remote -new-instance "${index_file}"
      WORKING_DIRECTORY "${out_docs_dir}"
      DEPENDS "${index_file}"
      VERBATIM
    )
  endif()
endfunction()


function(chcaux_qt_uic_resolve target #[[ui_n ...]])
  chc_assert_not_str_empty(Qt_VERSION)

  find_package(Qt${Qt_VERSION} COMPONENTS Core REQUIRED)
  get_target_property(uic_path Qt${Qt_VERSION}::uic LOCATION)
  chc_assert_not_variable(uic_path)
  cmake_path(NORMAL_PATH uic_path)

  foreach(ui_file_relative_path IN LISTS ARGN)
    cmake_path(ABSOLUTE_PATH ui_file_relative_path BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" NORMALIZE OUTPUT_VARIABLE ui_file_absolute_path)
    get_filename_component(ui_header_file_name "${ui_file_absolute_path}" NAME_WE)
    set(ui_header_file_name "ui_${ui_header_file_name}.h")
    cmake_path(SET ui_header_dir NORMALIZE "${CMAKE_CURRENT_BINARY_DIR}/uic")
    cmake_path(SET ui_header_file_path NORMALIZE "${ui_header_dir}/${ui_header_file_name}")
    add_custom_command(
      COMMAND "${uic_path}"
      --output "${ui_header_file_path}"
      --generator cpp
      --connections pmf
      "${ui_file_absolute_path}"
      OUTPUT "${ui_header_file_path}"
      DEPENDS "${ui_file_absolute_path}"
      WORKING_DIRECTORY "${ui_header_dir}"
      COMMENT "Uic generate from \"${ui_file_absolute_path}\" to \"${ui_header_file_path}\""
      COMMAND_EXPAND_LISTS
      VERBATIM
    )
    target_sources(${target} PRIVATE "${ui_header_file_path}" "${ui_file_absolute_path}")
    target_include_directories(${target} PRIVATE "${ui_header_dir}")
  endforeach()
endfunction()


function(chc_target_qt_define target #[[...]])
  set(options_keywords)
  set(one_value_keywords TYPE)
  set(multi_value_keywords SRCS LIBS UIC MOC #[[FONT]])
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options_keywords}" "${one_value_keywords}" "${multi_value_keywords}")

  chc_assert_not_str_empty(arg_TYPE)
  chc_assert_not_str_empty(arg_LIBS)
  chc_assert_not_str_empty(Qt_VERSION)

  set(sources "${arg_SRCS}")
  chc_assert_not_str_empty(sources)

  find_package(Qt${Qt_VERSION} COMPONENTS ${arg_LIBS} REQUIRED)

  if("${arg_TYPE}" STREQUAL "EXECUTABLE")
    cmake_language(CALL qt${Qt_VERSION}_add_executable ${target} "${sources}")

  elseif("${arg_TYPE}" STREQUAL "LIBRARY")
    set(type STATIC)
    if(BUILD_SHARED_LIBS)
      set(type SHARED)
    endif()
    cmake_language(CALL qt${Qt_VERSION}_add_library ${target} ${type} "${sources}")

  else()
    message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}. Unspecified type target. Type: ${arg_TYPE}")
  endif()

  target_compile_definitions(${target} PRIVATE
    QT_USE_QSTRINGBUILDER
  )
  list(TRANSFORM arg_LIBS PREPEND Qt${Qt_VERSION}::)
  target_link_libraries(${target} PRIVATE ${arg_LIBS})

  cmake_language(CALL qt${Qt_VERSION}_wrap_cpp moc_files "${arg_MOC}" TARGET ${target})
  target_sources(${target} PRIVATE "${moc_files}")

  chcaux_qt_uic_resolve(${target} "${arg_UIC}")

  #  if(NOT "${arg_FONT}" STREQUAL "")
  #    chcaux_qt_font_resolve(${target} ${arg_FONT})
  #  endif()
endfunction()


function(chcaux_qt_target_qt_type_assert)
  if(NOT ("${arg_TYPE}" STREQUAL "" AND NOT "TYPE" IN_LIST arg_KEYWORDS_MISSING_VALUES))
    message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}. The \"TYPE\" argument is not required for this call.")
  endif()
endfunction()


function(chc_target_qt_define_executable #[[...]])
  set(options_keywords)
  set(one_value_keywords TYPE)
  set(multi_value_keywords)
  cmake_parse_arguments(PARSE_ARGV 0 arg "${options_keywords}" "${one_value_keywords}" "${multi_value_keywords}")
  chcaux_qt_target_qt_type_assert()
  chc_target_qt_define(${arg_UNPARSED_ARGUMENTS} TYPE EXECUTABLE)
endfunction()
