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
  void on_pb_print_released() const;

private:
  QScopedPointer<Ui::MainWindow> const ui;
};
