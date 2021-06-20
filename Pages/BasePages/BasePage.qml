import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import QtGraphicalEffects 1.12
import "qrc:/Components/" as C
import "qrc:/Pages/MainPages/"
Page{
    id:mainPage
    Component.onCompleted: {
        dbFunctions.getAllData();
    }
    property int totalIncome: 0
    property int totalOutcome: 0
    property string finder: ""
    ListModel{id:allData}
    ListModel{id:incomeData}
    ListModel{id:outcomeData}
    C.DBFunctions{id:dbFunctions}
    C.OtherFunction{id:functions}
    anchors.fill: parent
    header : Header{id:headerItem}
    contentData: StackView{
        id:stack
        anchors.fill: parent
        anchors.left: parent.left
        anchors.leftMargin: functions.getWidthMargin(rootWindow)
        anchors.right: parent.right
        anchors.rightMargin: functions.getWidthMargin(rootWindow)
        clip: true
        initialItem: MainPage{}
        function callCurrentPageFunction(args)
        {
            currentItem.popOut(args)
        }
    }
    Shortcut {
        sequences: ["Esc", "Back"]
        onActivated: {
            if(stack.depth > 1)
                stack.pop()
            else exitDialog.open()
        }
    }
    Shortcut {
        sequences: ["F11","F5"]
        onActivated: {
            rootWindow.visibility = rootWindow.visibility===ApplicationWindow.FullScreen?ApplicationWindow.AutomaticVisibility
                                                                                        :ApplicationWindow.FullScreen
        }
    }
    C.ConfirmDialog{
        id:exitDialog
        dialogTitle: qsTr("Exit?")
        onAccepted: rootWindow.close()
        dialogText:qsTr("Do You Want to Exit Now?")
    }
}
