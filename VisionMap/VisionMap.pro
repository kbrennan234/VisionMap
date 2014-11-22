#-------------------------------------------------
#
# Project created by QtCreator 2014-11-21T17:07:35
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = VisionMap
TEMPLATE = app


SOURCES += main.cpp \
    dialog.cpp

HEADERS  += \
    dialog.h

FORMS    += \
    dialog.ui

INCLUDEPATH += C:\\opencv\\include

LIBS += -LC:\\opencv\\x86\\mingw\\bin \
    -lopencv_calib3d249 -lopencv_contrib249 \
    -lopencv_core249 -lopencv_features2d249 \
    -lopencv_ffmpeg249 -lopencv_flann249 \
    -lopencv_gpu249 -lopencv_highgui249 \
    -lopencv_imgproc249 -lopencv_legacy249 \
    -lopencv_ml249 -lopencv_nonfree249 \
    -lopencv_objdetect249 -lopencv_ocl249 \
    -lopencv_photo249 -lopencv_stitching249 \
    -lopencv_superres249 -lopencv_video249 \
    -lopencv_videostab249

RESOURCES += \
    resources.qrc
