import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "./" as Skin
Skin.Dialog {
    x: (parent.width- width)/2
    y: (parent.height- height)/2
    property alias text : textContainer.text
    property var callback
    property string msgTitle :""
    height: 160*size1W + textContainer.lineCount * 21*size1W
    hasBotton: true
    dialogButton.onClicked: {close()}
    onClosed: {
        if(callback!==undefined )
            callback();
    }
    buttonTitle: qsTr("Ok")
    dialogButton.anchors.bottomMargin: size1W*25
    Text {
        id: title
        text: msgTitle?msgTitle:qsTr("Error")
        font { family: styles.vazir; pixelSize: size1F*17;bold: true }
        anchors.top: parent.top
        anchors.topMargin: size1H*10
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        color: textColor
        Rectangle{
            color: "#ccc"
            height: size1H
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -size1H*5
            width: parent.width - size1W*40
        }
    }
    Text {
        id: textContainer
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: title.bottom
        anchors.topMargin: size1H*25
        anchors.right: parent.right
        anchors.rightMargin: size1W*15
        anchors.left: parent.left
        anchors.leftMargin: size1W*15
        font { family: styles.vazir; pixelSize: size1F*14 }
        color: textColor
    }

}
