import QtQuick 2.12
import Qt.labs.settings 1.0
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.5
import QtQuick.LocalStorage 2.12 as SQLITE
import "qrc:/Components/" as C
import ir.myco.Languages 1.0
import StatusBar 1.0

ApplicationWindow{
    id:rootWindow
    visible: true
    title: qsTr("Cute Money")

    minimumWidth:  375
    minimumHeight: 667

    width:  mySetting.value("width" ,375)
    height: mySetting.value("height",667)

    x:mySetting.value("appX",5)
    y:mySetting.value("appY",5)

    onClosing: {
        mySetting.setValue("appX",rootWindow.x)
        mySetting.setValue("appY",rootWindow.y)

        mySetting.setValue("width", rootWindow.width)
        mySetting.setValue("height",rootWindow.height)
    }

    //property string domain: "http://192.168.1.232:5010"
    property string domain: "https://drmyco.ir"

    property real size1W: functions.getWidthSize(1,rootWindow)
    property real size1H: functions.getHeightSize(1,rootWindow)
    property real size1F: functions.getFontSize(1,rootWindow)

    property var dataBase: SQLITE.LocalStorage.openDatabaseSync("TodoDB","1.0","TodoDB",10000)

    property bool isLightTheme: Material.theme === Material.Light
    property color textColor: isLightTheme? "Black"
                                          : "White"
    property int primaryColor: mySetting.value("appColor",5)
    property bool ltr: true// mytrans.getCurrentLanguage() === MycoLanguages.ENG ? true:false


    Material.theme: Number(mySetting.value("appTheme",1))
    Material.primary: primaryColor

    function setAppTheme(index)
    {
        Material.theme = index ===0 ? Material.Dark:Material.Light
        statusBar.color = isLightTheme?"#EAEAEA":"#171717"
    }
    function getAppTheme()
    {
        return isLightTheme
    }


    Settings{id:mySetting}
    C.Styles{id:styles}
    C.DBFunctions{id:dbFunctions}
    C.OtherFunction{id:functions}
    StatusBar {
        id:statusBar
        theme: isLightTheme?StatusBar.Light:StatusBar.Dark
        color: isLightTheme?"#EAEAEA":"#232323"
    }
    property var currentPerson

    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        Image {
            id:iconLogo
            source: "qrc:/Icons/icon.svg"
            width: 150*size1W
            height: width
            sourceSize.width: width*2
            sourceSize.height: height*2
            anchors.centerIn: parent
        }
        Text {
            text: "Cute Money"
            font{family: styles.lombok;pixelSize: 27*size1F;bold:true}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: iconLogo.bottom
            anchors.topMargin: 15*size1H
            color: textColor
        }
        DropShadow {
            id:dropShadow
            anchors.fill: iconLogo
            horizontalOffset: 0*size1W
            verticalOffset: 0*size1H
            radius: 50*size1W
            samples: 30*size1W
            color: Material.color(primaryColor,Material.Shade200)
            source: iconLogo
        }
    }
    Text {
        id: waitText
        text: qsTr("Made with ♥")
        font{family: styles.anurati;pixelSize: 12*size1F;bold:true}
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30*size1W
        anchors.horizontalCenter: parent.horizontalCenter
        color: textColor
    }
    SequentialAnimation{
        id:animationId
        running: true
        loops: Animation.Infinite
        PropertyAnimation {target:dropShadow; property: "opacity" ; to: 0.4;duration: 2000 }
        PropertyAnimation {target:dropShadow; property: "opacity" ; to: 1;duration: 2000 }
    }

    Loader{
        id:loader
        anchors.fill: parent
        asynchronous: true
        source: "qrc:/Pages/BasePages/BasePage.qml"
        onStatusChanged: {
            if(status === Loader.Ready)
                animationId.stop()
        }
    }
}
