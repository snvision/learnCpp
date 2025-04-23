set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(Qt_VERSION 6)

include("${PROJECT_SOURCE_DIR}/cmake/utils.cmake")

function(target_common target)
  target_include_directories(${target} PRIVATE "${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
endfunction()


function(add_console_exe target)
  set(options_keywords)
  set(one_value_keywords)
  set(multi_value_keywords SRCS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options_keywords}" "${one_value_keywords}" "${multi_value_keywords}")

  chc_assert_not_str_empty(arg_SRCS)

  add_executable(${target} ${arg_SRCS})
  target_common(${target})
endfunction()


function(add_qt_exe target)
  chc_target_qt_define_executable(${target} ${ARGN})
  target_common(${target})
endfunction()


file(GLOB sub_projects LIST_DIRECTORIES true CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/*")
foreach(i IN LISTS sub_projects)
  if(IS_DIRECTORY "${i}")
    add_subdirectory("${i}")
  endif()
endforeach()
