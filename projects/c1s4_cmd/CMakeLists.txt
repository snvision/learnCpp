set(name c1s4_cmd)

add_console_exe(${name}
  SRCS
    src/main.cpp
)

chc_doxygen_gen(${name})
