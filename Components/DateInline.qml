import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import ir.myco.date 1.0
import "qrc:/Components/" as C
Item {
    id:datePicker
    property alias datePickerRoot: datePicker
    property bool isShamsi: true
    property color textOnPrimary: "white"
    property date selectedDate : new Date()
    property date minSelectedDate;
    property date maxSelectedDate;
    property date tmpSelectedDate;
    property int displayMonth: getShamsiMonth(selectedDate.getTime()?selectedDate:new Date(),getLocale())-1
    property int displayYear: (selectedDate.getTime()?selectedDate:new Date()).getFullYear()
    property string displayPersianMonth: customDate.monthName()
    property int displayPersianYear: customDate.year
    property int displayPersianDayMonth: customDate.day
    property int calendarWidth: size1W*320
    property int calendarHeight: size1H*450
    property bool isOK: false
    property bool selectTime: false;
    width: 340*size1W
    height: 300*size1H
    CustomDate{
        id: customDate
    }
    GridLayout {
        id: calendarGrid
        visible: !datePicker.selectTime
        // column 0 only visible if Landscape
        columns: 3
        // row 0 only visible if Portrait
        rows: 5
        width: parent.width
        height: parent.height
        LayoutMirroring.enabled: isShamsi?true:false;
        LayoutMirroring.childrenInherit: isShamsi?true:false
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
                id: customDateNavigation
                locale:getLocale()
                date: datePickerRoot.selectedDate
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: size1W*6
                C.Button {
                    Layout.fillWidth: true
                    Layout.preferredWidth: size1W
                    text: !isShamsi? "<": ">"
                    flat: true
                    Material.foreground: isLightTheme?"black":"white"
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
                C.Button {
                    Layout.fillWidth: true
                    Layout.preferredWidth: size1W
                    text: isShamsi? "<":">"
                    flat: true
                    Material.foreground: isLightTheme?"black":"white"
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
        C.DayOfWeekRow {
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
    } // grid layout
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
