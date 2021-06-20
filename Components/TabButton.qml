import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

T.TabButton {
    property color activeColor: "#FF000000"
    property color textColor: "#99000000"
    property bool flat: false
    property alias backGround: bg1
    id: control
    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    baselineOffset: contentItem.y + contentItem.baselineOffset
    padding: 0
    spacing: size1H*6
    font { family: styles.vazir; pixelSize: size1F*12;bold:true;capitalization:Font.MixedCase }
    height: control.height
    contentItem:
        IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.checked ?activeColor:textColor //!control.enabled ? control.Material.hintTextColor : control.down || control.checked ? control.Material.accentColor : control.Material.foreground

        Rectangle{
            id:bg1
            anchors.fill: parent
            color: !control.checked ?"transparent":(flat)?"transparent":control.Material.accentColor
            radius: size1H*3
        }
    }
    background: Ripple {
        implicitHeight: control.height
        clip: true
        pressed: control.pressed
        anchor: control
        active: control.down || control.visualFocus || control.hovered
        color: control.Material.rippleColor
    }

}
