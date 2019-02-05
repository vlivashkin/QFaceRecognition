QT += quick multimedia
CONFIG += c++11

include(../../src/QFaceRecognition.pri)

CONFIG += resources_big

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

DEFINES += QFACERECOGNITION_QML

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

contains(QT_ARCH, i386): {
    CONFIG(release, debug|release): DESTDIR = $$PWD/../../bin/32
    else:CONFIG(debug, debug|release): DESTDIR = $$PWD/../../debug/32
}else{
    CONFIG(release, debug|release): DESTDIR = $$PWD/../../bin/64
    else:CONFIG(debug, debug|release): DESTDIR = $$PWD/../../debug/64
}

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../lib/ -ldlib
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../lib/ -ldlibd
else:unix: LIBS += -L$$PWD/../../lib/ -ldlib
