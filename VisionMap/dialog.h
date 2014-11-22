#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <QFileDialog>

namespace Ui {
class Dialog;
}

class Dialog : public QDialog
{
    Q_OBJECT

public:
    explicit Dialog(QWidget *parent = 0);
    ~Dialog();

private:
    Ui::Dialog *ui;

    cv::VideoCapture capture;
    cv::Mat src;
    cv::Mat dst;
    QImage frame;

    QTimer* timer;

    QString filename;
    bool playing;
    bool replay;

public slots:

private slots:
    void updateGUI();
    void drawMap();
    void on_btnPlay_clicked();
    void on_btnLoad_clicked();
    void reset();
    QString trimFilename(QString filename);
};

#endif // DIALOG_H
