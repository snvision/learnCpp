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
  // void on_pb_statement_released() const;
  void on_pb_data_released() const;
  void on_pb_value_released() const;
  void on_pb_object_released() const;
  void on_pb_variable_released() const;
  void on_pb_identifier_released() const;
  void on_pb_dataType_released() const;
  void on_pb_int_released() const;




private:
  QScopedPointer<Ui::MainWindow> const ui;
};