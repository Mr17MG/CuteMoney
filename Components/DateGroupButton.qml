import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import "." as Skin
Rectangle{
    property var groupBtnClick: function (button) { };
    id: rectangle
    radius: size1W*5
    border.color: styles.accentColor1
    border.width: size1W
    color:  "#CFF4F7"
    ButtonGroup { id: group
    onClicked: {
        if(button.text==="امروز")
            groupBtnClick("day");
        else if(button.text==="هفته")
            groupBtnClick("week")
        else if(button.text==="ماه")
            groupBtnClick("month")
        else if(button.text==="سال")
            groupBtnClick("year")
    }
    }

    Flow {
        id: flow1
        layoutDirection: Qt.RightToLeft
        anchors.fill: parent



        Button {
            id: b1
            checked: true
            text: qsTr("امروز")
            width: parent.width/4
            ButtonGroup.group: group
            Material.foreground: checked? "#FFFFFF":"#a0000000"
            Material.background: primaryColor
            height: parent.height
            font { family: styles.vazir; pixelSize: size1F*11; }
        }


        Button {
            id: b2
            checked: true
            text: qsTr("هفته")
            width: (parent.width-1)/4
            ButtonGroup.group: group
            Material.foreground: checked? "#FFFFFF":"#a0000000"
            Material.background: primaryColor
            height: parent.height
            font { family: styles.vazir; pixelSize: size1F*11; }
        }
        Button {
            id: b3
            checked: true
            text: qsTr("ماه")
            width: (parent.width)/4
            ButtonGroup.group: group
            Material.foreground: checked? "#FFFFFF":"#a0000000"
            Material.background: primaryColor
            height: parent.height
            font { family: styles.vazir; pixelSize: size1F*11; }
        }

        Button {
            id: b4
            checked: true
            text: qsTr("سال")
            width: parent.width/4
            ButtonGroup.group: group
//            Material.accent: styles.accentColor1
//            Material.foreground: checked? "#FFFFFF":"#a0000000"
//            Material.background: "transparent"
//            Material.primary: "transparent"
            height: parent.height
            font { family: styles.vazir; pixelSize: size1F*11; }
        }
    }




}

