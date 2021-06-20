import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "qrc:/Components/" as C

Item {
    Component.onCompleted: {
            loader.visible=true
            loader.source = "qrc:/Pages/BasePages/BasePage.qml"
    }
}
