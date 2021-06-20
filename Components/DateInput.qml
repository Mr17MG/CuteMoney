import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import ir.myco.date 1.0
import "./"
import QtGraphicalEffects 1.0
Item {

    id: item1
    property bool isShamsi: !ltr
    property bool hasTime: false
    property bool justTime: false
    property alias date: date
    property color textOnPrimary: "white"
    property string placeholderText: ""
    property color placeholderColor : Material.color(primaryColor)
    property alias datePicker: datePickerRoot
    property alias selectedDate: datePickerRoot.selectedDate
    property alias minSelectedDate: datePickerRoot.minSelectedDate
    property alias maxSelectedDate: datePickerRoot.maxSelectedDate
    property alias tmpSelectedDate: datePickerRoot.tmpSelectedDate
    property bool isLandscape: true
    property color bottomBorderColor: "red"
    property bool bottomBorderColorChanged : false
    property alias displayMouse: displayMouse
    property alias okButton: okButton
    function reset(){
        tmpSelectedDate = '';
        selectedDate = '';
    }

    Text {
        id: date
        text: !datePicker.selectedDate.getTime()?placeholderText : justTime?(("0"+datePickerRoot.selectedDate.getHours()).slice(-2)+":"+("0"+datePickerRoot.selectedDate.getMinutes()).slice(-2)):
                                                  dayName(Qt.formatDate(datePickerRoot.selectedDate, "ddd")) +", "+getShamsiDay(datePicker.selectedDate,getLocale())+". "+
                                                  getShamsiDate(datePicker.selectedDate,getLocale()).monthName()+" "+getShamsiYear(datePicker.selectedDate,getLocale()) +
                                                  (hasTime?" "+("0"+datePickerRoot.selectedDate.getHours()).slice(-2)+":"+("0"+datePickerRoot.selectedDate.getMinutes()).slice(-2):"");
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font { family: styles.vazir; pixelSize: size1F*14;}
        color: placeholderColor
        width: parent.width
        MouseArea{
            id:displayMouse
            anchors.fill: parent;
            cursorShape:Qt.PointingHandCursor
            onClicked: {
                tmpSelectedDate = selectedDate;
                if(!selectedDate.getTime())
                    selectedDate = new Date();
                if(justTime){
                    datePickerRoot.selectTime = true;
                }

                datePickerRoot.open();
                timePicker.setDisplay(Qt.formatTime(datePicker.selectedDate,"HH:mm"), timePicker.onlyQuartersAllowed, timePicker.useWorkTimes)
            }
        }
    }
    CustomDate{
        id: customDate
    }
    Rectangle{
        color:bottomBorderColorChanged?bottomBorderColor:Material.color(primaryColor);
        height: size1H*2
        width: parent.width
        y: parent.height - size1H*2
    }
    Popup {
        id: datePickerRoot
        property date selectedDate;
        property date minSelectedDate;
        property date maxSelectedDate;
        property date tmpSelectedDate;
        closePolicy: Popup.CloseOnPressOutside
        property int displayMonth: getShamsiMonth(selectedDate.getTime()?selectedDate:new Date(),getLocale())-1
        property int displayYear: (selectedDate.getTime()?selectedDate:new Date()).getFullYear()
        property string displayPersianMonth: customDate.monthName()
        property int displayPersianYear: customDate.year
        property int displayPersianDayMonth: customDate.day
        property int calendarWidth: size1W*320
        property int calendarHeight: size1H*450
        property bool isOK: false
        property bool selectTime: false;
        property var asolutePosition: getAbsolutePosition(date)
        modal: true
        x: ((rootWindow.width - calendarWidth ) / 2) - asolutePosition.x
        y: ((rootWindow.height - calendarHeight) / 2) - asolutePosition.y
        z: 2
        implicitWidth: calendarWidth
        implicitHeight: calendarHeight

        topPadding: 0
        leftPadding: 0
        rightPadding: 0

        GridLayout {
            id: calendarGrid
            visible: !datePicker.selectTime
            // column 0 only visible if Landscape
            columns: 3
            // row 0 only visible if Portrait
            rows: 5
            width: datePickerRoot.calendarWidth
            height: datePickerRoot.calendarHeight
            //layoutDirection: isShamsi?Qt.RightToLeft:Qt.LeftToRight
            LayoutMirroring.enabled: isShamsi?true:false;
            LayoutMirroring.childrenInherit: isShamsi?true:false
            Pane {
                id: portraitHeader
                //visible: !isLandscape
                padding: 0
                Layout.columnSpan: 2
                Layout.column: 1
                Layout.row: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Material.color(primaryColor)
                }
                ColumnLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: size1W*6
                    //layoutDirection: isShamsi?Qt.RightToLeft:Qt.LeftToRight
                    Label {
                        topPadding: size1H*12
                        leftPadding: size1W*24
                        rightPadding: size1W*24
                        font.pixelSize: size1F*18
                        text: getShamsiYear(datePicker.selectedDate,getLocale())
                        color: textOnPrimary
                        font.family: isShamsi?styles.vazir:font.family
                        opacity: 0.8
                    }
                    Label {
                        leftPadding: size1W*24
                        rightPadding: size1W*24
                        bottomPadding: size1H*12
                        font.pixelSize: size1F*30
                        font.family: isShamsi?styles.vazir:font.family
                        text: dayName(Qt.formatDate(datePickerRoot.selectedDate, "ddd")) +", "+getShamsiDay(datePicker.selectedDate,getLocale())+". "+getShamsiDate(datePicker.selectedDate,getLocale()).monthName()
                        color: textOnPrimary
                    }
                }
            } // portraitHeader

            // landscapeHeader

            ColumnLayout {
                id: title
                Layout.minimumHeight: size1H*55
                Layout.columnSpan: 2
                Layout.column: 1
                Layout.row: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: size1W*6
                layoutDirection: isShamsi?Qt.RightToLeft:Qt.LeftToRight
                CustomDate{
                    locale:getLocale()
                    id: customDateNavigation
                    date: datePickerRoot.selectedDate
                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: size1W*6
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredWidth: size1W
                        text: !isShamsi? "<": ">"
                        flat: true
                        Material.foreground: textColor
                        font.pixelSize: size1F*20
                        onClicked: {
                            var prevMonth = customDate.prevMonth();
                            if(maxSelectedDate && prevMonth <= minSelectedDate.setHours(0,0,0,0))
                                datePickerRoot.selectedDate = minSelectedDate;
                            else datePickerRoot.selectedDate = prevMonth;
                            datePickerRoot.displayMonth = customDate.month-1;
                            customDate.date = datePickerRoot.selectedDate;
                            monthgridflow.monthModel= customDate.monthDays(isShamsi);
                        }
                    }
                    Label {
                        Layout.fillWidth: true
                        Layout.preferredWidth: size1W*3
                        text: getShamsiDate(datePicker.selectedDate,getLocale()).monthName() + " " + getShamsiYear(datePicker.selectedDate,getLocale());
                        font.family: isShamsi?styles.vazir:font.family
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: size1F*18
                    }
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredWidth: size1W
                        text: isShamsi? "<":">"
                        flat: true
                        Material.foreground: textColor
                        font.pixelSize: size1F*20
                        onClicked: {
                            var nextMonth = customDate.nextMonth();
                            if(maxSelectedDate && nextMonth > maxSelectedDate.setHours(23,59,59,0))
                                datePickerRoot.selectedDate = maxSelectedDate;
                            else datePickerRoot.selectedDate = nextMonth;
                            datePickerRoot.displayMonth = customDate.month-1;
                            customDate.date = datePickerRoot.selectedDate;
                            monthgridflow.monthModel= customDate.monthDays(isShamsi);
                        }
                    }
                } // row layout title
            } // title column layout

            // TODO not working in dark theme
            DayOfWeekRow {
                locale: getLocale()
                id: dayOfWeekRow
                wheelEnabled: true
                hoverEnabled: true
                Layout.column: 2
                Layout.row: 2
                rightPadding: size1W*24
                leftPadding: size1W*24
                Layout.fillWidth: true
                font.bold: true
                font.pixelSize: size1F*13
                font.family: isShamsi?styles.vazir:font.family
                delegate: Label {
                    text: model.narrowName
                    font: dayOfWeekRow.font
                    color: Material.color(primaryColor)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            } // day of weeks

            /*// TODO not working in dark theme
            WeekNumberColumn {
                locale: getLocale()
                id: weekNumbers
                Layout.alignment: !isShamsi?Qt.AlignRight : Qt.AlignLeft
                Layout.column: 1
                Layout.row: 3
                Layout.fillHeight: true
                rightPadding: isShamsi?24:0
                leftPadding: isShamsi?0:24
                font.family: isShamsi?styles.vazir:font.family
                font.bold: false
                month: datePickerRoot.displayMonth
                year: datePickerRoot.displayYear
                delegate: Label {
                    text: model.weekNumber
                    font: weekNumbers.font
                    //font.bold: false
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            } */// WeekNumberColumn



//            MonthGrid {
//                visible: false
//                locale: isShamsi? Qt.locale("fa_IR"):Qt.locale("en_US")
//                id: monthGrid
//                Layout.column: 2
//                Layout.row: 3
//                Layout.fillHeight: true
//                Layout.fillWidth: true
//                rightPadding: size1W*24
//                leftPadding: size1W*24
//                topPadding: size1W*5
//                month: datePickerRoot.displayMonth
//                year: datePickerRoot.displayYear
//                day: (datePicker.selectedDate.getTime()?datePicker.selectedDate:new Date()).getDate()
//                realMonth: (datePicker.selectedDate.getTime()?datePicker.selectedDate:new Date()).getMonth()

//                delegate: Label {
//                    id: dayLabel
//                    property int day: getShamsiDay(model.date,getLocale());
//                    property int month: getShamsiMonth(model.date,getLocale())-1;
//                    readonly property bool selected: model.day === datePickerRoot.selectedDate.getDate()
//                                                     && model.month === datePickerRoot.selectedDate.getMonth()
//                                                     && model.year === datePickerRoot.selectedDate.getFullYear()
//                    text: day
//                    font.bold: model.today? true: false
//                    opacity: month === monthGrid.month ?isInRange(model.date)? 1 : 0.5 : 0
//                    color: pressed || selected ? textOnPrimary : model.today ? Material.accent : Material.foreground
//                    minimumPointSize: size1W*8
//                    font.pixelSize: size1F*14
//                    fontSizeMode: Text.Fit
//                    horizontalAlignment: Text.AlignHCenter
//                    verticalAlignment: Text.AlignVCenter
//                    font.family: isShamsi?styles.vazir:font.family
//                    background: Rectangle {
//                        anchors.centerIn: parent
//                        width: Math.min(parent.width, parent.height) * 1.2
//                        height: width
//                        radius: width / 2
//                        color: Material.color(primaryColor)
//                        visible: pressed || parent.selected
//                    }
//                    // WORKAROUND !! see onClicked()
//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: {
//                            if(month === monthGrid.month && isInRange(model.date)) {
//                                datePickerRoot.selectedDate = date;
//                            }
//                        }
//                    } // mouse
//                } // label in month grid
//            } // month grid
            Flow{
                id:monthgridflow
                Layout.column: 2
                Layout.row: 3
                Layout.fillHeight: true
                Layout.fillWidth: true
                rightPadding: size1W*24
                leftPadding: size1W*24
                topPadding: size1W*5
                property var monthModel: customDate.monthDays(isShamsi);
                Repeater{
                    model: parent.monthModel;
                    delegate: Label {
                        width: (monthgridflow.width-size1W*49)/7
                        height: width*4/5
                        id: dayLabel1
                        property int day: getShamsiDay(datePickerRoot.selectedDate,getLocale());
                        readonly property bool selected: day===modelData.day
                        text: modelData.day
                        font.bold: modelData.today? true: false
                        opacity: modelData.day === 0 ? 0 : isInRange(modelData.date)?1:0.5;
                        color:  control.pressed || selected ? textOnPrimary : model.today ? Material.accent : Material.foreground
                        minimumPointSize: size1W*8
                        font.pixelSize: size1F*14
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: isShamsi?styles.vazir:font.family
                        background: Rectangle {
                            anchors.centerIn: parent
                            width: Math.min(parent.width, parent.height) * 1.2
                            height: width
                            radius: width / 2
                            color: Material.color(primaryColor)
                            visible: control.pressed || parent.selected
                        }
                        // WORKAROUND !! see onClicked()
                        MouseArea {
                            id: control
                            anchors.fill: parent
                            onClicked: {
                                if(modelData.day !== 0 && isInRange(modelData.date)) {
                                    datePickerRoot.selectedDate = modelData.date;
                                }
                            }
                        } // mouse
                    } // label in month grid
                }//Repeater
            }

            ColumnLayout {
                Layout.column: 2
                Layout.row: 4
                id: footer
                Layout.minimumHeight: size1W*40
                Layout.fillWidth: true
                RowLayout {
                    Button {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 3
                        text: isShamsi?"امروز":"Today"
                        flat: true
                        Material.foreground: textColor
                        font.family: isShamsi?styles.vazir:font.family
                        font.pixelSize: size1F*14
                        onClicked: {
                            datePickerRoot.selectedDate = new Date()
                            datePickerRoot.displayMonth = getShamsiMonth(datePickerRoot.selectedDate,getLocale())-1
                            datePickerRoot.displayYear = datePickerRoot.selectedDate.getFullYear()
                            customDate.date = datePickerRoot.selectedDate;
                            monthgridflow.monthModel= customDate.monthDays(isShamsi);
                        }
                    } // cancel button
                    Button {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 3
                        font.family: isShamsi?styles.vazir:font.family
                        font.pixelSize: size1F*14
                        text: isShamsi?"انصراف":"Cancel"
                        flat: true
                        Material.foreground: textColor
                        onClicked: {
                            selectedDate = tmpSelectedDate;
                            datePickerRoot.close()
                        }
                    } // cancel button
                    Button {
                        id:okButton
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 3
                        font.family: isShamsi?styles.vazir:font.family
                        font.pixelSize: size1F*14
                        text: isShamsi?"تایید":"OK"
                        flat: true
                        Material.foreground: textColor
                        onClicked: {
                            if(hasTime)
                                datePickerRoot.selectTime= true;
                            else {
                                datePickerRoot.isOK = true;
                                datePickerRoot.close()
                            }
                        }
                    } // ok button
                }
            } // footer buttons
        } // grid layout

        onOpened: {
            datePickerRoot.isOK = false
            customDate.date = selectedDate;
            monthgridflow.monthModel= customDate.monthDays(isShamsi);
        }
        onClosed: {
            if(!datePickerRoot.isOK){
                selectedDate = tmpSelectedDate;
            }
            datePickerRoot.selectTime = false;
        }

        Item {
            id: timePicker
            anchors.fill: parent
            visible: datePicker.selectTime
            implicitWidth: parent.width
            implicitHeight: parent.height
            z: 2
            x:0
            y:0
            Material.elevation: 6

            //            Rectangle {color:"red"}

            property bool isOK: false

            property int timeButtonsPaneSize: Math.min(timePicker.implicitHeight, timePicker.implicitWidth) - size1W*40
            property int innerButtonsPaneSize: timeButtonsPaneSize - size1W*70

            // c1: circle 1 (outside) 1-12
            // c2: circle 2 (inside) 13-00
            // d: work day (outside) 7-18
            // n: night (inside) 19-6
            // m: minutes
            // q: only quarters allowed for minutes, disable the other ones
            // data model used to display labels on picker circles
            property var timePickerModel: [
                {"c1":"12","c2":"00","d":"12","n":"00","m":"00","q":true},
                {"c1":"1","c2":"13","d":"13","n":"1","m":"05","q":false},
                {"c1":"2","c2":"14","d":"14","n":"2","m":"10","q":false},
                {"c1":"3","c2":"15","d":"15","n":"3","m":"15","q":true},
                {"c1":"4","c2":"16","d":"16","n":"4","m":"20","q":false},
                {"c1":"5","c2":"17","d":"17","n":"5","m":"25","q":false},
                {"c1":"6","c2":"18","d":"18","n":"6","m":"30","q":true},
                {"c1":"7","c2":"19","d":"7","n":"19","m":"35","q":false},
                {"c1":"8","c2":"20","d":"8","n":"20","m":"40","q":false},
                {"c1":"9","c2":"21","d":"9","n":"21","m":"45","q":true},
                {"c1":"10","c2":"22","d":"10","n":"22","m":"50","q":false},
                {"c1":"11","c2":"23","d":"11","n":"23","m":"55","q":false}
            ]
            // this model used to display selected time
            // so you can add per ex. AM, PM or so
            property var timePickerDisplayModel: [
                {"c1":"12","c2":"00","d":"12","n":"00","m":"00","q":true},
                {"c1":"01","c2":"13","d":"13","n":"01","m":"05","q":false},
                {"c1":"02","c2":"14","d":"14","n":"02","m":"10","q":false},
                {"c1":"03","c2":"15","d":"15","n":"03","m":"15","q":true},
                {"c1":"04","c2":"16","d":"16","n":"04","m":"20","q":false},
                {"c1":"05","c2":"17","d":"17","n":"05","m":"25","q":false},
                {"c1":"06","c2":"18","d":"18","n":"06","m":"30","q":true},
                {"c1":"07","c2":"19","d":"07","n":"19","m":"35","q":false},
                {"c1":"08","c2":"20","d":"08","n":"20","m":"40","q":false},
                {"c1":"09","c2":"21","d":"09","n":"21","m":"45","q":true},
                {"c1":"10","c2":"22","d":"10","n":"22","m":"50","q":false},
                {"c1":"11","c2":"23","d":"11","n":"23","m":"55","q":false}
            ]

            // set these properties before start
            property int outerButtonIndex: 0
            property int innerButtonIndex: -1
            property bool pickMinutes: false
            property bool useWorkTimes: true
            property bool onlyQuartersAllowed: false
            property bool autoSwapToMinutes: true

            property string hrsDisplay: "12"
            property string minutesDisplay: "00"

            // opening TimePicker with a given HH:MM value
            // ATTENTION TimePicker is rounding DOWN to next lower 05 / 15 Minutes
            // if you want to round UP do it before calling this function
            function setDisplay(hhmm, q, w) {
                onlyQuartersAllowed = q
                useWorkTimes = w
                var s = hhmm.split(":")
                if(s.length === 2) {
                    var hours = s[0]
                    var minutes = s[1]
                    if(onlyQuartersAllowed) {
                        minutes = minutes - minutes%15
                    } else {
                        minutes = minutes - minutes%5
                    }
                    showMinutes(minutes)
                    showHour(hours)
                    checkDisplay()
                }
            }

            function showHour(hour) {
                for(var i=0; i < timePickerDisplayModel.length; i++) {
                    var h = timePickerDisplayModel[i]
                    if(useWorkTimes) {
                        if(h.d === hour) {
                            pickMinutes = false
                            innerButtonIndex = -1
                            outerButtonIndex = i
                            updateDisplayHour()
                            return
                        }
                        if(h.n === hour) {
                            pickMinutes = false
                            outerButtonIndex = -1
                            innerButtonIndex = i
                            updateDisplayHour()
                            return
                        }
                    } else {
                        if(h.c1 === hour) {
                            pickMinutes = false
                            innerButtonIndex = -1
                            outerButtonIndex = i
                            updateDisplayHour()
                            return
                        }
                        if(h.c2 === hour) {
                            pickMinutes = false
                            outerButtonIndex = -1
                            innerButtonIndex = i
                            updateDisplayHour()
                            return
                        }
                    }
                }
                // not found
                console.log("Minutes not found: "+hour)
                pickMinutes = false
                innerButtonIndex = -1
                outerButtonIndex = 0
                updateDisplayHour()
            }
            function updateDisplayHour() {
                if (innerButtonIndex >= 0) {
                    if(useWorkTimes) {
                        hrsDisplay = timePickerDisplayModel[innerButtonIndex].n
                    } else {
                        hrsDisplay = timePickerDisplayModel[innerButtonIndex].c2
                    }
                    return
                }
                if(timePicker.useWorkTimes) {
                    hrsDisplay = timePickerDisplayModel[outerButtonIndex].d
                } else {
                    hrsDisplay = timePickerDisplayModel[outerButtonIndex].c1
                }
            }

            function showMinutes(minutes) {
                minutes = ("0"+minutes).slice(-2);
                for(var i=0; i < timePickerDisplayModel.length; i++) {
                    var m = timePickerDisplayModel[i]
                    if(m.m === minutes) {
                        innerButtonIndex = -1
                        outerButtonIndex = i
                        pickMinutes = true
                        updateDisplayMinutes()
                        return
                    }
                }
                // not found
                console.log("Minutes not found: "+minutes)
                innerButtonIndex = -1
                outerButtonIndex = 0
                pickMinutes = true
                updateDisplayMinutes()
                return
            } // showMinutes
            function updateDisplayMinutes() {
                minutesDisplay = timePickerDisplayModel[outerButtonIndex].m
            }

            function checkDisplay() {
                if(pickMinutes) {
                    hrsButton.checked = false
                    minutesButton.checked = true
                } else {
                    minutesButton.checked = false
                    hrsButton.checked = true
                }
            }

            function onMinutesButtonClicked() {
                hrsButton.checked = false
                minutesButton.checked = true
                timePicker.pickMinutes = true
                timePicker.showMinutes(timePicker.minutesDisplay)
            }
            function onHoursButtonClicked() {
                minutesButton.checked = false
                hrsButton.checked = true
                timePicker.pickMinutes = false
                timePicker.showHour(timePicker.hrsDisplay)
            }

            Pane {
                id: headerPane
                padding: 0
                implicitWidth:  parent.width
                implicitHeight: size1H*110
                background: Rectangle {
                    color: Material.color(primaryColor)
                }

                GridLayout {
                    id: headerGrid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    anchors.centerIn: parent
                    rows: 1
                    columns: 3
                    rowSpacing: 0


                    Button {
                        id: hrsButton
                        focusPolicy: Qt.NoFocus
                        Layout.alignment: isLandscape? Text.AlignHCenter : Text.AlignRight
                        checked: true
                        checkable: true
                        flat: true
                        contentItem: Label {
                            text: timePicker.hrsDisplay
                            font.pixelSize: size1F*36
                            font.bold: false
                            fontSizeMode: Text.Fit
                            font.family: isShamsi?styles.vazir:font.family
                            opacity: hrsButton.checked ? 1.0 : 0.6
                            color: textOnPrimary
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            color: "transparent"
                        }
                        onClicked: {
                            timePicker.onHoursButtonClicked()
                        }
                    } // hrsButton

                    Label {
                        text: ":"
                        Layout.alignment: Text.AlignHCenter
                        font.pixelSize: size1F*36
                        font.bold: true
                        fontSizeMode: Text.Fit
                        font.family: isShamsi?styles.vazir:font.family
                        opacity: 0.6
                        color: textOnPrimary
                    }

                    Button {
                        id: minutesButton
                        focusPolicy: Qt.NoFocus
                        Layout.alignment: isLandscape? Text.AlignHCenter : Text.AlignLeft
                        checked: false
                        checkable: true
                        flat: true
                        contentItem: Label {
                            text: timePicker.minutesDisplay
                            font.pixelSize: size1F*36
                            font.bold: false
                            font.family: isShamsi?styles.vazir:font.family
                            fontSizeMode: Text.Fit
                            opacity: minutesButton.checked ? 1.0 : 0.6
                            color: textOnPrimary
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            color: "transparent"
                        }
                        onClicked: {
                            timePicker.onMinutesButtonClicked()
                        }
                    } // hrsButton
                } // header grid


            } // headerPane

            Pane {
                id: timeButtonsPane
                padding: 0
                x:0
                y:0
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.top: headerPane.bottom
                background: Rectangle {color: "transparent"}

                Rectangle {
                    anchors.centerIn: parent
                    width: timePicker.timeButtonsPaneSize + size1W*10
                    height: timePicker.timeButtonsPaneSize + 10
                    color: Material.color(Material.Grey, Material.Shade50)
                    radius: width / 2
                }

                Button {
                    text: isShamsi?"اکنون": "Now";
                    font.family: isShamsi?styles.vazir:font.family
                    font.pixelSize: size1F*14
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: size1W*10
                    anchors.topMargin: 0
                    flat: true
                    Material.foreground: textColor
                    onClicked: {
                        timePicker.setDisplay(Qt.formatTime(new Date(),"HH:mm"), timePicker.onlyQuartersAllowed, timePicker.useWorkTimes)
                    }
                }

                Button {
                    visible: !timePicker.pickMinutes
                    flat: true
                    Image {
                        id: buttonIcon
                        source: "qrc:/Icons/"+(timePicker.useWorkTimes? "portfolio.svg" : "clock.svg");
                        width: size1W*22
                        height: width
                        sourceSize.width: width*2
                        sourceSize.height: height*2
                        anchors.centerIn: parent
                        visible: false
                    }
                    ColorOverlay{
                        anchors.fill: buttonIcon
                        source: buttonIcon
                        color: textColor
                    }

                    width: size1W*40
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: size1W*10
                    anchors.topMargin: 0
                    //text:"work"
                    onClicked: {
                        timePicker.useWorkTimes = !timePicker.useWorkTimes
                        timePicker.showHour(timePicker.hrsDisplay)
                    }
                }
                Button {
                    visible: timePicker.pickMinutes
                    text: timePicker.onlyQuartersAllowed? "15" : "05"
                    font.family: isShamsi?styles.vazir:font.family
                    font.pixelSize: size1F*16
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: size1W*10
                    anchors.topMargin: 0
                    flat: true
                    Material.foreground: textColor
                    onClicked: {
                        timePicker.onlyQuartersAllowed = !timePicker.onlyQuartersAllowed
                        timePicker.showMinutes(timePicker.minutesDisplay)
                    }
                }

                ButtonGroup {
                    id: outerButtonGroup
                }
                ButtonGroup {
                    id: innerButtonGroup
                }

                Pane {

                    id: innerButtonsPane
                    implicitWidth: timePicker.innerButtonsPaneSize
                    implicitHeight: timePicker.innerButtonsPaneSize
                    padding: 0
                    visible: !timePicker.pickMinutes
                    anchors.centerIn: parent
                    background: Rectangle {color: "transparent"}

                    Repeater {
                        id: innerRepeater
                        model: timePicker.timePickerModel
                        delegate: Button {
                            id: innerButton
                            focusPolicy: Qt.NoFocus
                            text: timePicker.useWorkTimes? modelData.n : modelData.c2
                            font.bold: true
                            font.family: isShamsi?styles.vazir:font.family
                            font.pixelSize: size1F*25
                            x: timePicker.innerButtonsPaneSize / 2 - width / 2 //- 20
                            y: timePicker.innerButtonsPaneSize / 2 - height / 2 //- 20
                            width: size1W*40
                            height: size1W*40
                            checked: index == timePicker.innerButtonIndex
                            checkable: true

                            onClicked: {
                                timePicker.outerButtonIndex = -1
                                timePicker.innerButtonIndex = index
                                if(timePicker.useWorkTimes) {
                                    timePicker.hrsDisplay = timePicker.timePickerDisplayModel[index].n
                                } else {
                                    timePicker.hrsDisplay = timePicker.timePickerDisplayModel[index].c2
                                }
                                if(timePicker.autoSwapToMinutes) {
                                    timePicker.onMinutesButtonClicked()
                                }
                            }

                            ButtonGroup.group: innerButtonGroup

                            property real angle: 360 * (index / innerRepeater.count)

                            transform: [
                                Translate {
                                    y: -timePicker.innerButtonsPaneSize * 0.5 + innerButton.height / 2
                                },
                                Rotation {
                                    angle: innerButton.angle
                                    origin.x: innerButton.width / 2
                                    origin.y: innerButton.height / 2
                                }
                            ]

                            contentItem: Label {
                                text: innerButton.text
                                font: innerButton.font
                                fontSizeMode: Text.Fit
                                opacity: innerButton.checked ? 1.0 : enabled || innerButton.highlighted ? 1.0 : 0.6
                                color: innerButton.checked || innerButton.highlighted ? textOnPrimary : Material.color(Material.Grey, Material.Shade500)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                                rotation: -innerButton.angle
                            } // content Label

                            background: Rectangle {
                                color: innerButton.checked ? Material.color(primaryColor) : "transparent"
                                radius: width / 2
                            }
                        } // inner button
                    } // innerRepeater
                } // innerButtonsPane

                Repeater {

                    id: outerRepeater
                    model: timePicker.timePickerModel
                    delegate: Button {
                        id: outerButton
                        focusPolicy: Qt.NoFocus
                        text: timePicker.pickMinutes? modelData.m : timePicker.useWorkTimes? modelData.d : modelData.c1
                        font.bold: checked || timePicker.pickMinutes && timePicker.onlyQuartersAllowed
                        font.pixelSize: size1F*25
                        font.family: isShamsi?styles.vazir:font.family
                        x: (timePicker.timeButtonsPaneSize / 2) -size1W // (width / 2)
                        y: timePicker.timeButtonsPaneSize / 2  +size1W*5//+ height / 2
                        width: size1W*40
                        height: size1W*40
                        checked: index == timePicker.outerButtonIndex
                        checkable: true
                        enabled: timePicker.pickMinutes && timePicker.onlyQuartersAllowed? modelData.q : true

                        onClicked: {
                            timePicker.innerButtonIndex = -1
                            timePicker.outerButtonIndex = index
                            if(timePicker.pickMinutes) {
                                timePicker.minutesDisplay = timePicker.timePickerDisplayModel[index].m
                            } else {
                                if(timePicker.useWorkTimes) {
                                    timePicker.hrsDisplay = timePicker.timePickerDisplayModel[index].d
                                } else {
                                    timePicker.hrsDisplay = timePicker.timePickerDisplayModel[index].c1
                                }
                                if(timePicker.autoSwapToMinutes) {
                                    timePicker.onMinutesButtonClicked()
                                }
                            }
                        }

                        ButtonGroup.group: outerButtonGroup

                        property real angle: 360 * (index / outerRepeater.count)

                        transform: [
                            Translate {
                                y: -timePicker.timeButtonsPaneSize * 0.5 + outerButton.height / 2
                            },
                            Rotation {
                                angle: outerButton.angle
                                origin.x: outerButton.width / 2
                                origin.y: outerButton.height / 2
                            }
                        ]

                        contentItem: Label {
                            text: outerButton.text
                            font: outerButton.font
                            fontSizeMode: Text.Fit
                            opacity: enabled || outerButton.highlighted || outerButton.checked ? 1 : 0.3
                            color: outerButton.checked || outerButton.highlighted ? textOnPrimary : timePicker.pickMinutes && timePicker.onlyQuartersAllowed? Material.color(primaryColor) : "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            rotation: -outerButton.angle
                        } // outer content label

                        background: Rectangle {
                            color: outerButton.checked ? Material.color(primaryColor) : "transparent"
                            radius: width / 2
                        }
                    } // outer button
                } // outerRepeater



                Rectangle {
                    // line to outer buttons
                    visible: timePicker.outerButtonIndex >= 0
                    x: parent.width/2
                    y: timePicker.innerButtonsPaneSize / 2 - size1W*41
                    width: size1W
                    height: timePicker.timeButtonsPaneSize / 2 - size1W*40
                    transformOrigin: Item.Bottom
                    rotation: outerButtonGroup.checkedButton? outerButtonGroup.checkedButton.angle : 0
                    color: Material.color(primaryColor)
                    antialiasing: true
                } // line to outer buttons

                Rectangle {
                    // line to inner buttons
                    visible: timePicker.innerButtonIndex >= 0 && !timePicker.pickMinutes
                    x: parent.width/2
                    y: innerButtonsPane.height/2 -size1W*6
                    width: size1W
                    height: timePicker.innerButtonsPaneSize / 2 - size1W*40
                    transformOrigin: Item.Bottom
                    rotation: innerButtonGroup.checkedButton? innerButtonGroup.checkedButton.angle : 0
                    color: Material.color(primaryColor)
                    antialiasing: true
                } // line to outer buttons

                Rectangle {
                    // centerpoint
                    anchors.centerIn: parent
                    width: size1W*10
                    height: size1W*10
                    color: Material.color(primaryColor)
                    radius: width / 2
                }

            } // timeButtonsPane

            Pane {
                id: footerPane
                padding: 0
                anchors.right: parent.right
                y: parent.height - size1W*40

                implicitWidth: timePicker.timeButtonsPaneSize + size1W*40
                implicitHeight: size1W*40
                background: Rectangle {
                    color: "transparent"
                }
                ColumnLayout {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top

                    RowLayout {
                        Layout.fillHeight: true
                        Button {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            text: isShamsi? "تایید":"OK"
                            font.family: isShamsi?styles.vazir:font.family
                            font.pixelSize: size1F*14
                            z:100
                            flat: true
                            Material.foreground: textColor
                            onClicked: {
                                var a = datePickerRoot.selectedDate.setHours(timePicker.hrsDisplay,timePicker.minutesDisplay,0,0);
                                datePickerRoot.selectedDate = new Date(a);
                                datePickerRoot.isOK = true;
                                datePickerRoot.selectTime = false;
                                datePickerRoot.selectTime=false;
                                datePickerRoot.close();
                            }
                        } // ok button
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                        }
                        Button {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 1
                            flat: true
                            Material.foreground: textColor
                            text: isShamsi? "انصراف":"Cancel"
                            font.family: isShamsi?styles.vazir:font.family
                            font.pixelSize: size1F*14
                            onClicked: {
                                if(justTime)
                                    datePickerRoot.close()
                                else datePicker.selectTime = false
                            }
                        } // cancel button
                    } // button row
                } // button col

            } // footer pane

        } // timePicker

    } // popup calendar

    function getAbsolutePosition(node) {
        var returnPos = {};
        returnPos.x = 0;
        returnPos.y = 0;
        if(node !== undefined && node !== null) {
            var parentValue = getAbsolutePosition(node.parent);
            returnPos.x = parentValue.x + node.x;
            returnPos.y = parentValue.y + node.y;
        }
        return returnPos;
    }

    function monthName(i){
        //console.log(i)
        switch(i)
        {
        case 1:
            return "فروردین";
        case 2:
            return "اردیبهشت";
        case 3:
            return "خرداد";
        case 4:
            return "تیر";
        case 5:
            return "مرداد";
        case 6:
            return "شهریور";
        case 7:
            return "مهر";
        case 8:
            return "آبان";
        case 9:
            return "آذر";
        case 10:
            return "دی";
        case 11:
            return "بهمن";
        case 12:
            return "اسفند";
        }
    }
    function dayName(i){
        if(!isShamsi)
            return i
        switch(i)
        {
        case "Sat":
            return "شنبه";
        case "Sun":
            return "یک شنبه";
        case "Mon":
            return "دوشنبه";
        case "Tue":
            return "سه شنبه";
        case "Wed":
            return "چهارشنبه";
        case "Thu":
            return "پنج شنبه";
        case "Fri":
            return "جمعه";
        default :
            return i;
        }
    }
    function getShamsiDay(date,locale){
        customDate.date = date;
        customDate.locale = locale;
        return customDate.day;
    }
    function getShamsiMonth(date,locale){
        customDate.date = date;
        customDate.locale = locale;
        return customDate.month;
    }
    function getShamsiYear(date,locale){
        customDate.date = date;
        customDate.locale = locale;
        return customDate.year;
    }
    function getShamsiDate(date,locale){
        customDate.date = date;
        customDate.locale = locale;
        return customDate;
    }
    function isInRange(date){
        if(maxSelectedDate && date>maxSelectedDate.setHours(23,59,59,0)){
            return false;
        }
        if(minSelectedDate && date<minSelectedDate.setHours(0,0,0,0)){
            return false;
        }
        return true;
    }
    function addDays(date, days) {
        var result = new Date(date);
        result.setDate(result.getDate() + days);
        return result;
    }
    function getLocale(){
        return isShamsi? Qt.locale("fa_IR"):Qt.locale("en_US");
    }
}
