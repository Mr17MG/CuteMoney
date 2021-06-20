import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import QtGraphicalEffects 1.12

Drawer{
    id:drawer
    width: 225*size1W
    y: header.height
    height: parent.height - header.height
    Overlay.modal: Rectangle {
        color: isLightTheme?"#80000000":"#aa424242"
    }
    background:Rectangle{
        color: isLightTheme?"#f5f5f5":"#424242"
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(300*size1W, 0)
            gradient: Gradient {
                GradientStop {position: 0.0;color: isLightTheme?"#ffffff":"#30300"}
                GradientStop {position: 1.0;color: "transparent"}
            }
        }
    }
    Item {
        id:profileItem
        width: parent.width
        height: 120*size1H
        Rectangle{
            id: profileRect
            width: 100*size1W
            height: width
            radius: width
            anchors.centerIn: parent
            border.color: Material.color(primaryColor)
            border.width: 3*size1W
            Image {
                id: profileImage
                source: ""
                anchors.fill: parent
                sourceSize.width: parent.width
                sourceSize.height: parent.height
                anchors.margins: profileRect.border.width
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        x: profileRect.x
                        y: profileRect.y
                        width: profileRect.width
                        height: profileRect.height
                        radius: profileRect.radius
                    }
                }
            }
            MouseArea{
                id:profileMouse
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    drawer.close()
                    stack.push("qrc:/Pages/Profile/ProfileMain.qml")
                }
            }
        }
    }

    Item {
        id: accountsItem
        width: parent.width
        height: 25*size1H
        anchors.top: profileItem.bottom
        anchors.topMargin: 5*size1H
        Item {
            id: userNameItem
            width: parent.width
            height: 25*size1H
            Text {
                id: userNameText
                text: person.Firstname + " " + person.Lastname
                font{family: styles.vazir;pixelSize: 17*size1F;bold:true}
                color: textColor
                anchors.left: parent.left
                anchors.leftMargin: 15*size1W
                anchors.verticalCenter: parent.verticalCenter
            }
            //            Image {
            //                id: arrowIcon
            //                width: 15*size1W
            //                height: width
            //                source: "qrc:/Icons/arrow.svg"
            //                sourceSize.width: width*2
            //                sourceSize.height: height*2
            //                anchors.right: parent.right
            //                anchors.rightMargin: 15*size1W
            //                visible: false
            //            }
            //            ColorOverlay{
            //                id:arrowColor
            //                anchors.fill: arrowIcon
            //                source:arrowIcon
            //                color: textColor
            //            }
        }
        //        ListView{
        //            id:accountList
        //            width: parent.width
        //            height: 0
        //            visible: height
        //            anchors.top: userNameItem.bottom
        //            anchors.topMargin: 10*size1H
        //            spacing: 5*size1H
        //            clip: true
        //            onContentYChanged: {
        //                    if(contentY<0 || contentHeight < accountList.height)
        //                        contentY = 0
        //                    else if(contentY > (contentHeight + (model.count)-accountList.height))
        //                        contentY = (contentHeight + model.count)-accountList.height
        //            }
        //            onContentXChanged: {
        //                    if(contentX<0 || contentWidth < accountList.width)
        //                        contentX = 0
        //                    else if(contentX > (contentWidth-accountList.width))
        //                        contentX = (contentWidth-accountList.width)
        //            }
        //            Behavior on height {NumberAnimation{duration: 200}}

        //            delegate: Item {
        //                width: parent.width
        //                height: 25*size1H
        //                MouseArea{
        //                    anchors.fill: parent
        //                    cursorShape: Qt.PointingHandCursor
        //                    onClicked: {
        //                        drawer.close()
        //                        if(accountNameText.text === qsTr("Add Account"))
        //                        {
        ////                            loader.source = "qrc:/Pages/Authentication/Login.qml"
        //                            stack.push("qrc:/Pages/Authentication/Login.qml")
        //                        }
        //                        else{
        //                            currentPerson = loginPerson.get(index)
        //                            functions.getAllTask(currentPerson.Id)
        //                        }
        //                    }
        //                }
        //                Rectangle{
        //                    id: accountProfileRect
        //                    width: 25*size1W
        //                    height: width
        //                    radius: width
        //                    anchors.left: parent.left
        //                    anchors.leftMargin: 10*size1W
        //                    anchors.verticalCenter: parent.verticalCenter
        //                    color: "transparent"
        //                    Image {
        //                        id: accountImage
        //                        source: accountNameText.text === qsTr("Add Account")?"qrc:/Icons/plusIcon.svg"
        //                                                                         :"file:/media/MrMG/Pictures/me.png"
        //                        width: accountNameText.text === qsTr("Add Account")?20*size1W:parent.width
        //                        height: width
        //                        anchors.centerIn: parent
        //                        sourceSize.width: parent.width
        //                        sourceSize.height: parent.height
        //                        layer.enabled: true
        //                        layer.effect: OpacityMask {
        //                            maskSource: Rectangle {
        //                                x: accountProfileRect.x
        //                                y: accountProfileRect.y
        //                                width: accountProfileRect.width
        //                                height: accountProfileRect.height
        //                                radius: accountProfileRect.radius
        //                            }
        //                        }
        //                    }
        //                    ColorOverlay{
        //                        source: accountImage
        //                        anchors.fill: accountNameText.text === qsTr("Add Account")?accountImage:undefined
        //                        color: textColor
        //                    }
        //                }
        //                Image {
        //                    id: checkIcon
        //                    width: 15*size1W
        //                    height: width
        //                    source: "qrc:/Icons/check.svg"
        //                    sourceSize.width: width*2
        //                    sourceSize.height: height*2
        //                    anchors.bottom: accountProfileRect.bottom
        //                    anchors.bottomMargin: -3*size1H
        //                    anchors.right: accountProfileRect.right
        //                    anchors.rightMargin: -7*size1W
        //                    visible: model.UserName===currentPerson.UserName
        //                }
        //                Text {
        //                    id: accountNameText
        //                    text: UserName
        //                    font{family: styles.vazir;pixelSize: 13*size1F;bold:false}
        //                    color: textColor
        //                    anchors.left: accountProfileRect.right
        //                    anchors.leftMargin: 15*size1W
        //                    anchors.verticalCenter: parent.verticalCenter
        //                }
        //            }
        //            model:loginPerson
        //            Component.onCompleted: {
        //                accountList.model.append({"UserName":qsTr("Add Account")})
        //            }
        //        }
    }
    Rectangle{
        color: "#bebebe"
        width: 1*size1W
        height: parent.width
        anchors.top: listView.top
        anchors.topMargin: -115*size1H
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 90
        gradient: Gradient {
            GradientStop {position: 0;color: "transparent"}
            GradientStop {position: 0.5;color: textColor}
            GradientStop {position: 1.0;color: "transparent"}
        }
    }
    ListView{
        id:listView
        anchors.top: accountsItem.bottom
        anchors.topMargin: 10*size1H
        anchors.bottom: logOutBtn.top
        anchors.bottomMargin: 10*size1H
        anchors.right: parent.right
        anchors.left: parent.left
        clip: true
        onContentYChanged: {
            if(contentY<0 || contentHeight < listView.height)
                contentY = 0
            else if(contentY > (contentHeight + (model.count)-listView.height))
                contentY = (contentHeight + model.count)-listView.height
        }
        delegate: Item {
            id: listDelegate
            width: parent.width
            height: 40*size1H
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    drawer.close()
                    if(pageSource!=="")
                        stack.push(pageSource)
                }
            }
            Image {
                id: icon
                width: 20*size1W
                height: width
                source: "qrc:/Icons/"+iconName+".svg"
                sourceSize.width: width*2
                sourceSize.height: height*2
                anchors.left: parent.left
                anchors.leftMargin: 10*size1W
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }
            ColorOverlay{
                anchors.fill: icon
                source:icon
                color: textColor
                transform:rotation
                antialiasing: true
            }
            Text {
                id: name
                text: title
                anchors.verticalCenter: parent.verticalCenter
                font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
                color: textColor
                anchors.left: icon.right
                anchors.leftMargin: 25*size1W
                anchors.right: parent.right
            }
        }
        model: ListModel{
            ListElement{
                title:qsTr("My Friends")
                pageSource : "qrc:/Pages/Friends/FriendsMain.qml"
                iconName: "Drawer/friends"
            }
            ListElement{
                title:qsTr("priorities")
                pageSource : ""
                iconName: ""
            }
            ListElement{
                title:qsTr("Contexts")
                pageSource : ""
                iconName: ""
            }
            ListElement{
                title:qsTr("Settings")
                pageSource : "qrc:/Pages/Setting.qml"
                iconName: "setting"
            }
        }
    }

    RoundButton{
        id:logOutBtn
        width: 100*size1W
        height: 50*size1H
        text: qsTr("Log Out")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10*size1H
        anchors.left: parent.left
        anchors.leftMargin: 10*size1W
        Material.background: primaryColor
        Material.foreground: "white"
        Material.theme: Material.Light
        font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
        onClicked: {
            drawer.close()
            //            functions.deleteLoginPerson(currentPerson.Id)
            //            if(loginPerson.count===2)
            //            {
            //                loader.source= allPersonList.count>0? "qrc:/Pages/Authentication/Login.qml"
            //                                                    : "qrc:/Pages/Authentication/SignUp.qml"
            //            }
            //            else {
            //                console.log("not Working Please Repair Me!")
            //            }
        }
    }
    RoundButton{
        id:exitBtn
        width: 100*size1W
        height: 50*size1H
        text: qsTr("Profile")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10*size1H
        anchors.right: parent.right
        anchors.rightMargin: 10*size1W
        Material.background: primaryColor
        Material.foreground: "white"
        Material.theme: Material.Light
        font{family: styles.vazir;pixelSize: 14*size1F;bold:false}
        onClicked: {
            profileMouse.clicked(Qt.RightButton)
        }
    }
}

