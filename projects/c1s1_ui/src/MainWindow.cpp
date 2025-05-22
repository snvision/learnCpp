#include <c1s1_ui/MainWindow.hpp>

#include <ui_MainWindow.h>


MainWindow::~MainWindow() = default;


MainWindow::MainWindow(QWidget* parent)
  : QMainWindow{parent}
, ui{new Ui::MainWindow} {
  ui->setupUi(this);
}


void MainWindow::on_pb_main_released() const {
  ui->l_main_answer->setText("main()");
}

void MainWindow::on_pb_statement_released() const {
  ui->l_statement_answer->setText("Statement — type of instruction in computer program, "
                                    "that telling computer to perform an action.");
}

void MainWindow::on_pb_function_released() const {
  ui->l_function_answer->setText("Function — a named sequence of statements, "
                                   "that can be reused several times.");
}

void MainWindow::on_pb_run_released() const {
  ui->l_run_answer->setText("The statements in main() are executed in sequence order.");
}

void MainWindow::on_pb_symbol_released() const {
  ui->l_symbol_answer->setText(";");
}

void MainWindow::on_pb_error_released() const {
  ui->l_error_answer->setText("Syntax error — error in using rules of the C++ language.");
}

void MainWindow::on_pb_library_released() const {
  ui->l_library_answer->setText("Library — code for subsequence reuse.");
}