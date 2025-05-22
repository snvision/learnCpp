#include <c1s4_ui/MainWindow.hpp>

#include <ui_MainWindow.h>


MainWindow::~MainWindow() = default;


MainWindow::MainWindow(QWidget* parent)
  : QMainWindow{parent}
    , ui{new Ui::MainWindow} {
  ui->setupUi(this);
}


void MainWindow::on_pb_diff_released() const {
  ui->l_diff_answer->setText("Initialization — get variable value when it is defined. \n"
                               "Assigment — get variable value after when it is defined.");
}

void MainWindow::on_pb_value_released() const {
  ui->l_value_answer->setText("Direct-list initialization — {}.");
}

void MainWindow::on_pb_variants_released() const {
  ui->l_variants_answer->setText("Default-initialization — initialization with no initializator. Example: int width. \n"
                                   "Value-initialization — initialization with {}. Initializator — 0 or another nearest value, "
                                   "depending on the data type of the variable.");
}