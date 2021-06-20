import QtQuick 2.12
import QtGraphicalEffects 1.0
Item {
    property bool isMoving: true
    property bool moving: true
    property alias rightHandImage: rightHandImage
    property alias leftHandImage: leftHandImage
    property alias leftMonsterEye: leftMonsterEye
    property alias rightMonsterEye: rightMonsterEye
    width: 141*size1W
    height: 210*size1H

    Image{
        id:monsterImage
        width: 141*size1W
        height: width
        source: "qrc:/Icons/Monster/monster.svg"
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin:0
        SequentialAnimation{
            id:moveAnimation
            running: isMoving
            loops: Animation.Infinite
            NumberAnimation { target: monsterImage; property: "anchors.topMargin"; to: 25*size1H; duration: 1000}
            NumberAnimation { target: monsterImage; property: "anchors.topMargin"; to: 0; duration: 1000}
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                isMoving = !moveAnimation.running
            }
        }
    }

    Rectangle{
        id:rightMonsterEyeBack
        width: 23*size1W
        height: width
        radius: width
        anchors.top: monsterImage.top
        anchors.topMargin: 45*size1H
        anchors.left: monsterImage.horizontalCenter
        anchors.leftMargin: 13*size1W
        z:20
        border.color: "black"
        border.width: 1*size1W
        Rectangle{
            id:rightMonsterEye
            anchors.centerIn: parent
            width: 10*size1W
            height: width
            radius: width
            color: "black"
            Rectangle{
                anchors.left: parent.left
                anchors.leftMargin: -1*size1W
                anchors.top: parent.top
                anchors.topMargin: 1*size1H
                color: "white"
                width: 6*size1W
                height: width
                radius: width
            }
        }
    }

    Rectangle{
        id:leftMonsterEyeBack
        width: 30*size1W
        height: width
        radius: width
        anchors.top: monsterImage.top
        anchors.topMargin: 52*size1H
        anchors.right: monsterImage.horizontalCenter
        anchors.rightMargin: 10*size1W
        z:20
        border.color: "black"
        border.width: 1*size1W
        clip: true
        Rectangle{
            id:leftMonsterEye
            anchors.centerIn: parent
            width: 13*size1W
            height: width
            radius: width
            color: "black"
            Rectangle{
                anchors.left: parent.left
                anchors.leftMargin: -1*size1W
                anchors.top: parent.top
                anchors.topMargin: -1*size1W
                width: 8*size1W
                color: "white"
                height: width
                radius: width
            }
        }
    }


    Image{
        id:rightWingImage
        width: 31*size1W
        height: 36*size1H
        source: "qrc:/Icons/Monster/RightWingMonseter.svg"
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.bottom: monsterImage.top
        anchors.bottomMargin: -30*size1H
        anchors.left: monsterImage.right
        anchors.leftMargin: -22*size1W
    }
    Image{
        id:leftWingImage
        width: 31*size1W
        height: 36*size1W
        source: "qrc:/Icons/Monster/leftWingMonster.svg"
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.bottom: monsterImage.top
        anchors.bottomMargin: -32*size1H
        anchors.right: monsterImage.left
        anchors.rightMargin: -22*size1W
    }

    Image{
        id:leftHandImage
        source: "qrc:/Icons/Monster/leftHandMonster.svg"
        width: 14*size1W
        height: 40*size1H
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.bottom: monsterImage.bottom
        anchors.bottomMargin: 17*size1H
        anchors.left: monsterImage.right
        anchors.leftMargin: -12*size1W
        z:20
        Behavior on width{NumberAnimation{duration: 100}}
        Behavior on height{NumberAnimation{duration: 100}}
        Behavior on rotation{NumberAnimation{duration: 10}}
        Behavior on anchors.bottomMargin {NumberAnimation{duration: 100}}
        Behavior on anchors.leftMargin{NumberAnimation{duration: 100}}
    }
    Image{
        id:rightHandImage
        width: 14*size1W
        height: 40*size1H
        source: "qrc:/Icons/Monster/rightHandMonseter.svg"
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.bottom: monsterImage.bottom
        anchors.bottomMargin: 13*size1H
        anchors.right: monsterImage.left
        anchors.rightMargin: -17*size1W
        z:20
        Behavior on width{NumberAnimation{duration: 100}}
        Behavior on height{NumberAnimation{duration: 100}}
        Behavior on rotation{NumberAnimation{duration: 10}}
        Behavior on anchors.bottomMargin {NumberAnimation{duration: 100}}
        Behavior on anchors.rightMargin{NumberAnimation{duration: 100}}
    }

    Image{
        id:shadowImage
        width: 104*size1W
        height: 25*size1H
        source: "qrc:/Icons/Monster/shadow.svg"
        sourceSize.width: width*2
        sourceSize.height: height*2
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
    }
    ColorOverlay{
        id:shadowColor
        anchors.fill: shadowImage
        source:shadowImage
        color:"#606060"
        transform:rotation
        antialiasing: true
        opacity: 0.5
        SequentialAnimation {
            id:anim
            running: moveAnimation.running
            loops: Animation.Infinite
            PropertyAnimation {
                target: shadowColor
                property: "color"
                to: "#1C1C1C"
                duration: 1000
            }
            PropertyAnimation {
                target: shadowColor
                property: "color"
                to: "#5F5F5F"
                duration: 1000
            }
        }
    }

    Timer{
        id:wingTimer
        interval: 100
        repeat: true
        running: moving
        onTriggered: {
            if(rightWingImage.height ==60*size1H)
            {
                rightWingImage.height = 36*size1H
                rightWingImage.width = 31*size1W
                leftWingImage.height = 36*size1H
                leftWingImage.width = 31*size1W
            }
            else{
                rightWingImage.height = 60*size1H
                rightWingImage.width = 8*size1W
                leftWingImage.height = 60*size1H
                leftWingImage.width = 8*size1W
            }
        }
    }
}
