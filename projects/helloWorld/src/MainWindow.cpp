#include <helloWorld/MainWindow.hpp>

#include <ui_MainWindow.h>


MainWindow::~MainWindow() = default;


MainWindow::MainWindow(QWidget* parent)
    : QMainWindow{parent}
    , ui{new Ui::MainWindow} {
  ui->setupUi(this);
}

/// @brief When you click on the button, text appears "Hello World!"
void MainWindow::on_pb_print_released() const {
  ui->l_printedText->setText("Hello World!");
}
