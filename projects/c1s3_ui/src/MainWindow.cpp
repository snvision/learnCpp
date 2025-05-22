#include <c1s3_ui/MainWindow.hpp>

#include <ui_MainWindow.h>


MainWindow::~MainWindow() = default;


MainWindow::MainWindow(QWidget* parent)
  : QMainWindow{parent}
    , ui{new Ui::MainWindow} {
  ui->setupUi(this);
}


void MainWindow::on_pb_data_released() const {
  ui->l_data_answer->setText("Data — information, that can be processed, "
                               "transmitted and stored.");
}

void MainWindow::on_pb_value_released() const {
  ui->l_value_answer->setText("Value — data placed in the instance.");
}

void MainWindow::on_pb_object_released() const {
  ui->l_object_answer->setText("Object or instance — an area in memory that can be store a value.");
}

void MainWindow::on_pb_variable_released() const {
  ui->l_variable_answer->setText("Variable — named instance.");
}

void MainWindow::on_pb_identifier_released() const {
  ui->l_identifier_answer->setText("Identifier — variable name.");
}

void MainWindow::on_pb_dataType_released() const {
  ui->l_dataType_answer->setText("Data type used for identify which value the object will store.");
}

void MainWindow::on_pb_int_released() const {
  ui->l_int_answer->setText("Integer — number without fractional part.");
}