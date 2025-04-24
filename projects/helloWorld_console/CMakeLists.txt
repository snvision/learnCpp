set(name helloWorld_console)

add_console_exe(${name}
  SRCS
    src/main.cpp
)

chc_doxygen_gen(${name})
