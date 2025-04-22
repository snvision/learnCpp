set(name helloWorld)

add_executable(${name}
    src/main.cpp
    MainWindow.h src/MainWindow.cpp ui/MainWindow.ui
)

target_include_directories(${name} PRIVATE
  "${PROJECT_SOURCE_DIR}/projects"
)

target_link_libraries(${name} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(${name} PROPERTIES
  AUTOMOC ON
  AUTOUIC ON
  #AUTORCC ON
  INCLUDE_CURRENT_DIR ON
  AUTOUIC_SEARCH_PATHS ui
  )


if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(${name})
endif()
