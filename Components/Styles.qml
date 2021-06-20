import QtQuick 2.0

Item {
    property alias vazir: vazirFont.name
    property alias lombok: lombokFont.name
    property alias anurati: anuratiFont.name
    FontLoader{
        id:vazirFont
        name : "Vazir"
        source: "qrc:/Fonts/Vazir.ttf"
    }
    FontLoader{
        id:lombokFont
        name:"Lombok"
        source: "qrc:/Fonts/Lombok.otf"
    }
    FontLoader{
        id:anuratiFont
        name:"Anurati-Regular"
        source: "qrc:/Fonts/Anurati-Regular.otf"
    }
}
