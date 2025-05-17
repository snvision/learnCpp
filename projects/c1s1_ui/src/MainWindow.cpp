#include <c1s1_ui/MainWindow.hpp>

#include <ui_MainWindow.h>


MainWindow::~MainWindow() = default;


MainWindow::MainWindow(QWidget* parent)
  : QMainWindow{parent}
    , ui{new Ui::MainWindow} {
  ui->setupUi(this);
}


void MainWindow::on_pb_main_released() const {
  ui->l_main_answer->setText("Answer1");
}

void MainWindow::on_pb_statement_released() const {
  ui->l_statement_answer->setText("Answer2");
}

void MainWindow::on_pb_function_released() const {
  ui->l_function_answer->setText("Answer3");
}

void MainWindow::on_pb_run_released() const {
  ui->l_run_answer->setText("Answer4");
}

void MainWindow::on_pb_symbol_released() const {
  ui->l_symbol_answer->setText("Answer5");
}

void MainWindow::on_pb_error_released() const {
  ui->l_error_answer->setText("Answer6");
}

void MainWindow::on_pb_library_released() const {
  ui->l_library_answer->setText("Answer7");
}