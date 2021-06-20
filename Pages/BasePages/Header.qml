import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import QtGraphicalEffects 1.12
import "qrc:/Components" as C

Item {
    id: headerItem
    width: parent.width
    height:50*size1H
    Component.onCompleted: {
        statusBar.color = isLightTheme?"#EAEAEA":"#171717"
    }

    Rectangle{
        id:backRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: headerItem.height - size1H
        color: isLightTheme?"white":"#212121"
        clip: true
        Button{
            id:menuBtn
            width: 30*size1W
            height: 40*size1H
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10*size1W
            visible: stack.depth>1
            Material.background: Material.shade("transparent",0)
            onClicked: {
                if(stack.depth>1)
                {
                    stack.pop()
                }
                else {

                }
            }
            Image{
                id:menuImage
                source: stack.depth>1?"qrc:/Icons/arrow.svg"
                                     :""
                width: parent.width - 10*size1W
                anchors.centerIn: parent
                height: width
                sourceSize.width: width*2
                sourceSize.height: height*2
                visible: false
            }
            ColorOverlay{
                id:menuColor
                anchors.fill: menuImage
                source:menuImage
                color:Material.color(primaryColor)
                rotation: stack.depth>1?90:0
            }
        }
        Label {
            id: title
            text: "Cute Money"
            font{family: styles.lombok;pixelSize: 22*size1F;bold:true}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: menuBtn.verticalCenter
            color: textColor
        }
        Button{
            id:calendarBtn
            width: 35*size1W
            height: 45*size1H
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10*size1W
            Material.background: Material.shade("transparent",0)
            onClicked: {
                stack.push("qrc:/Pages/Setting.qml")
            }
            Image{
                id:calendarImage
                source: "qrc:/Icons/setting.svg"
                width: parent.width -10*size1W
                anchors.centerIn: parent
                height: width
                sourceSize.width: width*2
                sourceSize.height: height*2
                visible: false
            }
            ColorOverlay{
                id:calendatColor
                anchors.fill: calendarImage
                source:calendarImage
                color:Material.color(primaryColor)
                transform:rotation
                antialiasing: true
            }
        }
    }
    RectangularGlow {
        id: effect
        anchors.fill: backRect
        glowRadius: 2
        spread: 0.1
        color: textColor
        cornerRadius: backRect.radius + glowRadius
        z:-1
    }
}

