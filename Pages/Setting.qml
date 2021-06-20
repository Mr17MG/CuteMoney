import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import "qrc:/Components/" as C
Item {
    Item{
        id:themeItem
        width: 340*size1W
        height: themeFlow.height
        anchors.top: parent.top
        anchors.topMargin: 10*size1W
        anchors.horizontalCenter: parent.horizontalCenter
        Flow{
            id:themeFlow
            spacing: 10*size1W
            Text{
                text: qsTr("Choose Your Theme : ")
                font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                verticalAlignment: Text.AlignVCenter
                color: textColor
                height: themeSwitch.height
                leftPadding: 10*size1W
            }
            Text{
                text: qsTr("Light")
                font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                verticalAlignment: Text.AlignVCenter
                color: textColor
                height: themeSwitch.height
            }
            C.Switch{
                id: themeSwitch
                Material.accent: primaryColor
                Material.theme: Material.Light
                checked: isLightTheme?false:true
                onCheckedChanged: {
                    setAppTheme(checked?0:1)
                    mySetting.setValue("appTheme",checked?Material.Dark:Material.Light)
                }
            }
            Text{
                text: qsTr("Dark")
                font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                verticalAlignment: Text.AlignVCenter
                color: textColor
                height: themeSwitch.height
            }
        }
    }
    Item {
        id: colorItem
        anchors.top: themeItem.bottom
        anchors.topMargin: 5*size1W
        width: 340*size1W
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            id:colorText
            text: qsTr("Choose Your Color : ")
            font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
            verticalAlignment: Text.AlignBottom
            color: textColor
            height: primaryCombo.height
            anchors.left: parent.left
            anchors.leftMargin: 10*size1W
            anchors.bottom: primaryCombo.bottom
        }
        C.ComboBox{
            id:primaryCombo
            width: 185*size1W
            height: 40*size1H
            anchors.left: colorText.right
            anchors.leftMargin: 10*size1W
            displayText : currentIndex === -1 ? "Colors"
                                              : currentText
            currentIndex : primaryColor
            font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
            model:[qsTr("Red"),qsTr("Pink"),qsTr("Purple"),qsTr("DeepPurple"),qsTr("Indigo"),qsTr("Blue"),
                qsTr("LightBlue"),qsTr("Cyan"),qsTr("Teal"),qsTr("Green"),qsTr("LightGreen"),qsTr("Lime"),
                qsTr("Yellow"),qsTr("Amber"),qsTr("Orange"),qsTr("DeepOrange"),qsTr("Brown"),qsTr("Grey"),
                qsTr("BlueGrey")]
            delegate: ItemDelegate {
                id: colorDelegate
                text: modelData
                width: primaryCombo.popup.width
                height: 48*size1H

                font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                Rectangle {
                    z: -1
                    anchors.fill: parent
                    parent: colorDelegate.background
                    color: Material.color(index)
                }
            }
            onCurrentIndexChanged: {
                primaryColor = currentIndex
                mySetting.setValue("appColor",currentIndex)
            }
        }
    }
}
