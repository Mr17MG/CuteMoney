import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "qrc:/Components/" as C
import QtGraphicalEffects 1.0

Item {
    property real loaderHeight: 0

    C.ConfirmDialog{
        id:deleteDialog
        property int recordId: -1
        dialogTitle: qsTr("Delete?")
        onAccepted: dbFunctions.deleteData(recordId)
        dialogText:qsTr("Are You Sure to Delete This Record")
    }

    C.Dialog{
        id: insertDialog
        property bool isEditing: false
        property int recordId: -1
        height: 360*size1H
        hasBotton: true
        hasCloseIcon: true
        hasTitle: true
        dialogTitle: qsTr("close")
        dialogButton.text: isEditing?qsTr("Update"):qsTr("Add")
        dialogButton.onClicked: {
            if(titleInput.text.trim() === ""){
                functions.showErrorLog(qsTr("Please Enter Title of Record"),true)
                return
            }
            if(amountInput.text.trim() === "" && Number(amountInput.text.trim()) > 0){
                functions.showErrorLog(qsTr("Please Enter Amount of Record"),true)
                return
            }
            if(!isEditing)
            {
                dbFunctions.insertData(amountInput.text.trim().replace(/,/ig,"")
                                       ,titleInput.text.trim()
                                       ,income.checked?1:0
                                       ,dateInput.selectedDate.toString() === "Invalid Date" ?(new Date()).getTime()
                                                                                             :dateInput.selectedDate.getTime()
                                       )
            }
            else {
                dbFunctions.updateData(recordId
                                       ,amountInput.text.trim().replace(/,/ig,"")
                                       ,titleInput.text.trim()
                                       ,income.checked?1:0
                                       ,dateInput.selectedDate.toString() === "Invalid Date" ?(new Date()).getTime()
                                                                                             :dateInput.selectedDate.getTime()
                                       )
            }

            titleInput.text = ""
            amountInput.text = ""
            dateInput.reset()
            income.checked = false
            insertDialog.close()
        }

        property alias titleInput: titleInput
        property alias amountInput: amountInput
        property alias dateInput: dateInput
        property alias income: income
        Flow{
            anchors.top: parent.top
            anchors.topMargin: 25*size1W
            width: 220*size1W
            anchors.horizontalCenter: parent.horizontalCenter
            C.TextField{
                id:titleInput
                placeholderText: qsTr("Title")
                width: parent.width
                height: 55*size1H
            }
            C.TextField{
                id:amountInput
                placeholderText: qsTr("Amount") + "("+ qsTr("Tooman") + ")"
                width: parent.width
                height: 55*size1H
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator { regExp: /[0-9۰-۹]+/ }
                onTextChanged: {
                    text = functions.currencyFormat(Number(text.replace(/,/ig,"")))
                }
            }
            C.DateInput{
                id:dateInput
                placeholderText: qsTr("Date")
                width: parent.width
                height: 40*size1H
                hasTime: true
            }
            Text{
                width: parent.width
                wrapMode: Text.WordWrap
                text: qsTr("Leave Blank For choose Current Date and Time")
                color: textColor
                font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
            }

            C.CheckBox{
                id:income
                text: qsTr("Income")
                Material.accent: primaryColor
                width: parent.width
                font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
            }
        }
    }

    Flickable{
        id:control
        contentHeight: mainItem.height
        ScrollBar.vertical: ScrollBar {
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Vertical
            anchors.right: control.right
            height: parent.height
            width: 8*size1W
        }
        onContentYChanged: {
            if(contentY>30)
                addBtn.anchors.bottomMargin=-size1H*60
            else if(contentY<30)
                addBtn.anchors.bottomMargin=size1H*10

            if(contentY<0 || contentHeight < control.height)
                contentY = 0
            else if(contentY > (contentHeight-control.height))
                contentY = contentHeight-control.height
        }
        onContentXChanged: {
            if(contentX<0 || contentWidth < control.width)
                contentX = 0
            else if(contentX > (contentWidth-control.width))
                contentX = (contentWidth-control.width)
        }
        flickableDirection: Flickable.VerticalFlick
        anchors.fill: parent
        clip: true
        Item{
            id:mainItem
            width: parent.width
            height: topItem.height + bottomItem.height - tabBar.height
            Item {
                id:topItem
                width: parent.width
                height: filterBox.checked?200*size1W:140*size1W
                clip: true
                Label{
                    id:incomeLabel
                    text: qsTr("Income") +":"
                    anchors.left: parent.left
                    anchors.leftMargin: 10*size1W
                    anchors.top: parent.top
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                }
                Text{
                    id:incomeText
                    text: functions.currencyFormat(totalIncome) + " " +qsTr("Tooman")
                    anchors.left: incomeLabel.right
                    anchors.leftMargin: 10*size1W
                    anchors.top: parent.top
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                }
                Label{
                    id:outcomeLabel
                    text: qsTr("Outcome") +":"
                    anchors.left: parent.left
                    anchors.leftMargin: 10*size1W
                    anchors.top: incomeLabel.bottom
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                }
                Text{
                    id:outcomeText
                    text: functions.currencyFormat(totalOutcome) +" " +qsTr("Tooman")
                    anchors.left: outcomeLabel.right
                    anchors.leftMargin: 10*size1W
                    anchors.top: incomeLabel.bottom
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                }
                Label{
                    id:totalLabel
                    text: qsTr("Total") +":"
                    anchors.left: parent.left
                    anchors.leftMargin: 10*size1W
                    anchors.top: outcomeText.bottom
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                }
                Text{
                    id:totalText
                    text: functions.currencyFormat(totalIncome-totalOutcome) +" " +qsTr("Tooman")
                    anchors.left: totalLabel.right
                    anchors.leftMargin: 10*size1W
                    anchors.top: outcomeText.bottom
                    anchors.topMargin: 10*size1H
                    color: textColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                }
                C.CheckBox{
                    id:filterBox
                    anchors.top:  totalText.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 10*size1W
                    Material.accent: primaryColor
                    font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                    text: qsTr("Show Filter")
                    onCheckedChanged: {
                        if(!checked)
                        {
                            startDate.reset()
                            endDate.reset()
                            finder=""
                            dbFunctions.getAllData()
                        }
                    }
                }
                C.DateInput{
                    id:startDate
                    width: parent.width/2 - 10*size1W
                    height: 50*size1H
                    anchors.top: filterBox.bottom
                    anchors.topMargin: -5*size1W
                    visible: filterBox.checked
                    placeholderText: qsTr("Start Date")
                    anchors.left: parent.left
                    onSelectedDateChanged: {
                        if(startDate.selectedDate.toString() !== "Invalid Date")
                        {
                            finder = "Where ModifyDate >= \'" + selectedDate.getTime()+"\'"
                            if(endDate.selectedDate.toString() !== "Invalid Date"){
                                finder += " And ModifyDate <= \'" + endDate.selectedDate.getTime() +"\'"
                            }
                        }
                        dbFunctions.getAllData()
                    }
                }
                C.DateInput{
                    id:endDate
                    width: parent.width/2 - 10*size1W
                    height: 50*size1H
                    anchors.top: filterBox.bottom
                    anchors.topMargin: -5*size1W
                    visible: filterBox.checked
                    anchors.right: parent.right
                    placeholderText: qsTr("End Date")
                    onSelectedDateChanged: {
                        if(endDate.selectedDate.toString() !== "Invalid Date")
                        {
                            finder = "Where ModifyDate <= \'" + selectedDate.getTime()+"\'"
                            if(startDate.selectedDate.toString() !== "Invalid Date"){
                                finder += " And ModifyDate >= \'" + startDate.selectedDate.getTime()+"\'"
                            }
                        }
                        dbFunctions.getAllData()
                    }
                }
            }
            Rectangle{
                id:breakLine
                width: parent.width
                color: textColor
                height: 1*size1W
                anchors.top: topItem.bottom
            }
            Item{
                id: bottomItem
                width: parent.width
                height: rootWindow.height
                anchors.top: breakLine.bottom
                TabBar{
                    id:tabBar
                    width: parent.width
                    height: 50*size1H
                    Material.accent: textColor
                    Material.background: Material.color(primaryColor,Material.Shade500)
                    Material.foreground: textColor
                    C.TabButton{
                        text: qsTr("All")
                        Material.accent: Material.color(primaryColor,Material.Shade500)
                        activeColor: isLightTheme?"black":"white"
                        textColor: "#cccccc"
                    }
                    C.TabButton{
                        text: qsTr("Income")
                        Material.accent: Material.color(primaryColor,Material.Shade500)
                        activeColor: isLightTheme?"black":"white"
                        textColor: "#cccccc"
                    }
                    C.TabButton{
                        text: qsTr("Outcome")
                        Material.accent: Material.color(primaryColor,Material.Shade500)
                        activeColor: isLightTheme?"black":"white"
                        textColor: "#cccccc"
                    }
                }

                C.ListView{
                    id: listview
                    anchors.top: tabBar.bottom
                    anchors.topMargin: 10*size1H
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10*size1H
                    spacing : 5*size1H
                    width: parent.width
                    model: tabBar.currentIndex === 0?allData:tabBar.currentIndex === 1?incomeData:outcomeData
                    clip: true
                    emptyListText: qsTr("No data recorded")
                    emptyListColor: textColor
                    delegate:Item{
                        width: parent.width
                        height: 100*size1H
                        Rectangle{
                            height: 95*size1H
                            width: parent.width
                            color: Material.color(primaryColor,Material.Shade100)

                            MouseArea{
                                id: control2
                                anchors.fill: parent
                                cursorShape:Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                hoverEnabled: true
                                onEntered: {
                                    hovered: true
                                    control2.focus=true
                                }
                                onExited: {
                                    hovered: false
                                    control2.focus=false
                                }
                                onPressAndHold: {
                                    if((Qt.platform.os=="android" || Qt.platform.os=="ios"))
                                    {
                                        contexMenu.x = mouseX
                                        contexMenu.y = mouseY
                                        contexMenu.open()
                                    }
                                }
                                onClicked: {
                                    if(!(Qt.platform.os=="android" || Qt.platform.os=="ios") && mouse.button === Qt.RightButton)
                                    {
                                        contexMenu.x = mouseX
                                        contexMenu.y = mouseY
                                        contexMenu.open()
                                    }
                                }
                            }
                            C.Menu {
                                id: contexMenu
                                width: 140*size1W
                                modal: true
                                topPadding: 0
                                bottomPadding: 0
                                font { family: styles.vazir; pixelSize: size1F*15;bold:false }
                                C.MenuItem {
                                    text: qsTr("Edit")
                                    icon.source: "qrc:/Icons/EditIcon.svg"
                                    onTriggered: {
                                        insertDialog.isEditing = true
                                        insertDialog.recordId = model.Id
                                        insertDialog.titleInput.text = model.Title
                                        insertDialog.amountInput.text = model.Amount
                                        insertDialog.income.checked = model.Type===1
                                        insertDialog.dateInput.selectedDate = new Date(Number(model.ModifyDate))
                                        insertDialog.open()
                                    }
                                }
                                C.MenuSeparator{topPadding: 0;bottomPadding: 0}
                                C.MenuItem {
                                    text: qsTr("Delete")
                                    icon.source: "qrc:/Icons/trashIcon.svg"
                                    onTriggered: {
                                        deleteDialog.recordId = model.Id
                                        deleteDialog.open()
                                    }
                                }
                            }
                            Text {
                                id:titleText
                                text: model.Title
                                anchors.left: parent.left
                                anchors.leftMargin: 10*size1W
                                anchors.right: parent.right
                                anchors.rightMargin: 10*size1W
                                anchors.top: parent.top
                                anchors.topMargin: 5*size1H
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                                font{family: styles.vazir;pixelSize: 14*size1F;bold:true}
                            }
                            Text {
                                id: dateText
                                text: qsTr("Amount")+": "+ (functions.currencyFormat(Number(model.Amount))) + " " + qsTr("Tooman")
                                anchors.left: parent.left
                                anchors.leftMargin: 10*size1W
                                anchors.right: parent.right
                                anchors.rightMargin: 10*size1W
                                anchors.top: titleText.bottom
                                anchors.topMargin: 5*size1H
                                elide: Text.ElideRight
                                font{family: styles.vazir;pixelSize: 12*size1F;bold:false}
                            }
                            Text {
                                property date thisDate: new Date(Number(model.ModifyDate))
                                text: thisDate.getFullYear()+"/"+(thisDate.getMonth()+1) + "/" + thisDate.getDate()+"-" + thisDate.getHours()+":" + thisDate.getMinutes()
                                anchors.left: parent.left
                                anchors.leftMargin: 10*size1W
                                anchors.right: parent.right
                                anchors.rightMargin: 10*size1W
                                anchors.top: dateText.bottom
                                anchors.topMargin: 5*size1H
                                elide: Text.ElideRight
                                font{family: styles.vazir;pixelSize: 12*size1F;bold:false}
                            }
                            Image{
                                width: 50*size1W
                                height: width
                                source:model.Type === 1 ? "qrc:/Icons/income.svg":"qrc:/Icons/outcome.svg"
                                sourceSize.width: width*2
                                sourceSize.height: height*2
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10*size1W
                                anchors.right: parent.right
                                anchors.rightMargin: 10*size1W
                            }
                        }
                    }
                }
            }
        }
    }
    C.Button{
        id:addBtn
        width: 50*size1W
        height: width
        bottomRadius: width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10*size1W
        anchors.right: parent.right
        anchors.rightMargin: 10*size1W
        Material.background: primaryColor
        onClicked: {
            insertDialog.isEditing = false
            insertDialog.open()
        }
        Behavior on anchors.bottomMargin { NumberAnimation{duration: 200}}
        Image {
            id: plusImg
            source: "qrc:/Icons/plusIcon.svg"
            sourceSize.width: width*2
            sourceSize.height: height*2
            width: 35*size1W
            height: width
            anchors.centerIn: parent
            visible: false
        }
        ColorOverlay{
            source: plusImg
            anchors.fill: plusImg
            color: textColor
        }
    }
}
