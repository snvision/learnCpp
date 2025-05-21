set(name c1s1_ui)

add_qt_exe(${name}
  LIBS Widgets
  SRCS
    src/main.cpp
    MainWindow.hpp src/MainWindow.cpp
  MOC MainWindow.hpp
  UIC ui/MainWindow.ui
)

chc_doxygen_gen(${name})
