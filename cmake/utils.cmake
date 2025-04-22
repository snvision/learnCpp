include_guard(GLOBAL)


function(doxygen_gen target)
  find_program(doxygen_exe doxygen REQUIRED)
  get_target_property(src_dir ${target} SOURCE_DIR)
  get_target_property(bin_dir ${target} BINARY_DIR)
  get_target_property(sources ${target} SOURCES)
  set(out_docs_dir "${src_dir}/docs")
  set(index_file "${out_docs_dir}/html/index.html")

  set(doxygen_param
    "PROJECT_NAME = \"${target}\""
    "OUTPUT_DIRECTORY = \"${out_docs_dir}\""
    "INPUT = \"${src_dir}\""
    "EXCLUDE = \"${out_docs_dir}\""
    "RECURSIVE = YES"
    "QUIET = YES"
  )
  list(TRANSFORM doxygen_param APPEND "\n")
  string(REPLACE ";" "" doxygen_param "${doxygen_param}")
  set(doxygen_param_file "${out_docs_dir}/doxygen_parameters.txt")
  file(WRITE "${doxygen_param_file}" "${doxygen_param}")

  add_custom_command(
    COMMAND "${CMAKE_COMMAND}" -E cat "${doxygen_param_file}" | "${doxygen_exe}" -
    WORKING_DIRECTORY "${bin_dir}"
    COMMAND_EXPAND_LISTS
    VERBATIM
    USES_TERMINAL
    OUTPUT "${index_file}"
    DEPENDS ${sources}
  )
  add_custom_target(${target}_doxygen
    DEPENDS "${index_file}"
  )

  find_program(firefox_bin firefox)
  if(NOT firefox_bin-NOTFOUND)
    add_custom_target(${target}_doxygen_show
      COMMAND "${firefox_bin}" "${index_file}"
      WORKING_DIRECTORY "${out_docs_dir}"
      DEPENDS "${index_file}"
    )
  endif()
endfunction()
