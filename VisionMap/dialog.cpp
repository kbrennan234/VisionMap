#include "dialog.h"
#include "ui_dialog.h"
#include <QtCore>

Dialog::Dialog(QWidget* parent) : QDialog(parent), ui(new Ui::Dialog) {
    ui->setupUi(this);
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(updateGUI()));

    replay = false;
    playing = false;

    ui->btnPlay->setEnabled(false);

    Dialog::drawMap();
}

Dialog::~Dialog() {
    delete ui;
}

void Dialog::updateGUI() {
    capture.read(src);

    if (src.empty()) {
        Dialog::reset();
    }

    cv::resize(src, dst, cv::Size(480, 360), 0, 0, CV_INTER_CUBIC);

    cv::cvtColor(dst, dst, CV_BGR2RGB);

    QImage qvideo((uchar*)dst.data, dst.cols, dst.rows, dst.step, QImage::Format_RGB888);
    ui->lblVideo->setPixmap(QPixmap::fromImage(qvideo));
}

void Dialog::drawMap() {
    QImage map = QImage(":/images/map.png");
    ui->lblMap->setPixmap(QPixmap::fromImage(map));
}

void Dialog::reset() {
    timer->stop();
    playing = false;
    replay = true;
    ui->btnPlay->setText("RePlay");
}

void Dialog::on_btnLoad_clicked() {
    if (playing) {
        timer->stop();
    }
    playing = false;
    ui->btnPlay->setEnabled(false);

    filename = QFileDialog::getOpenFileName(this, tr("Open File"), "", tr("Files (*.*)"));
    capture.open(filename.toLocal8Bit().constData());

    if (!capture.isOpened()) {
        ui->lblVideo->setText("Unable to load file: \n" + filename);
        return;
    }
    ui->lblFilename->setText(trimFilename(filename));

    Dialog::updateGUI();
    ui->btnPlay->setEnabled(true);
}

void Dialog::on_btnPlay_clicked() {
    playing = !playing;

    if (playing) {
        if (replay) {
            replay = false;
            capture.open(filename.toLocal8Bit().constData());
        }
        timer->start(20);
        ui->btnPlay->setText("Pause");
    } else {
        timer->stop();
        ui->btnPlay->setText("Play");
    }
}

QString Dialog::trimFilename(QString filename) {
    std::string tmp = filename.toLocal8Bit().constData();
    tmp = tmp.substr(tmp.find_last_of("\\/"),tmp.length());

    return QString::fromStdString(tmp);
}
