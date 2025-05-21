#pragma once

#include <QMainWindow>
#include <QScopedPointer>


namespace Ui {
class MainWindow;
}


class MainWindow final : public QMainWindow {
  Q_OBJECT

public:
  ~MainWindow() override;
  MainWindow(QWidget* parent = nullptr);

private slots:
  void on_pb_main_released() const;
  void on_pb_statement_released() const;
  void on_pb_function_released() const;
  void on_pb_run_released() const;
  void on_pb_symbol_released() const;
  void on_pb_error_released() const;
  void on_pb_library_released() const;




private:
  QScopedPointer<Ui::MainWindow> const ui;
};