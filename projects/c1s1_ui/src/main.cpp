#include <QApplication>

#include <helloWorld/MainWindow.hpp>


int main(int argc, char* argv[]) {
  QApplication app{argc, argv};
  MainWindow   w;
  w.show();
  return QApplication::exec();
}
