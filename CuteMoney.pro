QT += quick svg core  quickcontrols2
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

RESOURCES += qml.qrc

SOURCES += \
        main.cpp \
        src/qcustomdate.cpp \
        src/qdateconvertor.cpp

HEADERS += \
    src/languages.h \
    src/qcustomdate.h \
    src/qdateconvertor.h \
    src/translator.h


include(./Projects/statusBar/statusbar.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
#QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


#contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
#    ANDROID_PACKAGE_SOURCE_DIR = \
#        $$PWD/android
#}
#win32{
#    RC_ICONS= ./icon.ico # TODO:add Icon for windows
#}
android {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

    DISTFILES += \
        android/AndroidManifest.xml \
        android/build.gradle \
        android/gradle/wrapper/gradle-wrapper.jar \
        android/gradle/wrapper/gradle-wrapper.properties \
        android/gradlew \
        android/gradlew.bat \
        android/res/values/libs.xml \
        android/res/values/styles.xml
}
