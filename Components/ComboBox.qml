import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0
ComboBox {
    Material.background: "transparent"
    property int popupX: 0
    property int popupY: popupCenter?(-(rootWindow.height-height)/2)-control.y:50
    property bool popupCenter: false
    property int popupWidth: width
    property int popupHeight: rootWindow.height>= delegateModel.count*size1H*48?delegateModel.count*size1H*48:rootWindow.height-size1H*50
    property bool hasBottomBorder: true
    property alias contentItemText: contentItemText
    property int textAlign: ltr?Text.AlignLeft:Text.AlignRight
    property string placeholderText: ""
    property color bottomBorderColor: "red"
    property bool bottomBorderColorChanged : false
    property alias imageIndicator: imageIndicator
    id:control
    height: size1H*30
    font { family: styles.vazir; pixelSize: size1F*14;bold: true }
    indicator: Image {
        id:imageIndicator
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: ltr?(contentItemText.width/2)-size1W*10:-(contentItemText.width/2)+size1W*10
        source: "qrc:/Icons/arrow.svg"
        width: size1W*8
        height: size1H*8
        sourceSize.width: width*2
        sourceSize.height: height*2
        visible: false
    }
    ColorOverlay{
        source: imageIndicator
        anchors.fill: imageIndicator
        color: Material.color(primaryColor)
    }

    contentItem: Rectangle {
        id:contentItem
        anchors.fill: parent
        color: "transparent"
        Label{
            id:contentItemText
            text: parent.parent.displayText?parent.parent.displayText:placeholderText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font: control.font
            color: textColor
        }
        Rectangle{
            color:bottomBorderColorChanged?bottomBorderColor:Material.color(primaryColor);
            height: size1H*2;
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            visible: hasBottomBorder
        }
    }
    delegate: MenuItem {
        id: delegateItem
        width: parent.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        Material.foreground: control.currentIndex === index ? parent.Material.accent : parent.Material.foreground
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
        font { family: styles.vazir; pixelSize: size1F*14; }
        height: size1H*48
        contentItem: Text {
            id: name
            text: parent.text
            font: parent.font
            width: parent.width
            anchors.rightMargin: size1W*15
            anchors.leftMargin: size1W*15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: textAlign
            wrapMode: Text.WordWrap
            color: textColor
        }
    }
    popup: T.Popup {
        y: popupY
        onVisibleChanged: {
        //    console.log(y+" "+popupY)
        }

        x: popupCenter?(+(rootWindow.width-popupWidth)/2)-(popupX/2)-(control.x):popupX
        width: control.popupWidth
        height: popupHeight
        transformOrigin: Item.Top
        topMargin: size1H*12
        bottomMargin: size1H*12

        Material.theme: control.Material.theme
        Material.accent: control.Material.accent
        Material.primary: control.Material.primary

        enter: Transition {
            // grow_fade_in
            NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            // shrink_fade_out
            NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: ListView {
            clip: true

            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: size1W*5
            color: control.popup.Material.dialogColor
            layer.enabled: control.enabled
            layer.effect: ElevationEffect {
                elevation: 8
            }
        }
    }
}

