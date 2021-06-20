import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.impl 2.12

TextField{
    id:textField
    property alias placeholder: textFieldPlaceHolder
    property alias toolTip: tooltip
    Material.accent: primaryColor
    font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
    selectByMouse: true
    renderType:Text.NativeRendering
    placeholderTextColor: "transparent"
    ToolTip{
        id:tooltip
        timeout: 6000
        x:textField.width-width
        y:(textField.height-height)/2
        font{family: styles.vazir;pixelSize: 10*size1F;bold:true}
    }
    PlaceholderText {
        id: textFieldPlaceHolder
        text: textField.placeholderText
        color: textField.focus || textField.text!=""? isLightTheme?"#B3000000":"#B3ffffff":textColor
        anchors.bottom: textField.bottom
        anchors.bottomMargin: textField.focus || textField.text!=""?40*size1H:15*size1H
        anchors.left: textField.left
//        anchors.leftMargin: textField.focus || textField.text!=""?0:15
        font{family: styles.vazir;pixelSize:( textField.focus || textField.text!=""?12*size1F:14*size1F);bold:true}
        Behavior on anchors.bottomMargin {
            NumberAnimation{ duration: 160}
        }
//        Behavior on anchors.leftMargin {
//            NumberAnimation{ duration: 160}
//        }
//        Behavior on font.pixelSize {
//            NumberAnimation{ duration: 160}
//        }
    }
}
