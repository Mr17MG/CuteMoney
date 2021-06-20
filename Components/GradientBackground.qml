import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.5

Rectangle{
    color: "#66ffffff"
    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(rootWindow.width, rootWindow.height)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: Material.color(0); to: Material.color(1); duration: 2000 }
                    ColorAnimation { from: Material.color(1); to: Material.color(2); duration: 2000 }
                    ColorAnimation { from: Material.color(2); to: Material.color(3); duration: 2000 }
                    ColorAnimation { from: Material.color(3); to: Material.color(4); duration: 2000 }
                    ColorAnimation { from: Material.color(4); to: Material.color(5); duration: 2000 }
                    ColorAnimation { from: Material.color(5); to: Material.color(6); duration: 2000 }
                    ColorAnimation { from: Material.color(6); to: Material.color(7); duration: 2000 }
                    ColorAnimation { from: Material.color(7); to: Material.color(8); duration: 2000 }
                    ColorAnimation { from: Material.color(8); to: Material.color(9); duration: 2000 }
                    ColorAnimation { from: Material.color(9); to: Material.color(10); duration: 2000 }
                    ColorAnimation { from: Material.color(10); to: Material.color(11); duration: 2000 }
                    ColorAnimation { from: Material.color(11); to: Material.color(12); duration: 2000 }
                    ColorAnimation { from: Material.color(12); to: Material.color(13); duration: 2000 }
                    ColorAnimation { from: Material.color(13); to: Material.color(14); duration: 2000 }
                    ColorAnimation { from: Material.color(14); to: Material.color(15); duration: 2000 }
                    ColorAnimation { from: Material.color(15); to: Material.color(16); duration: 2000 }
                    ColorAnimation { from: Material.color(16); to: Material.color(17); duration: 2000 }
                    ColorAnimation { from: Material.color(17); to: Material.color(18); duration: 2000 }
                    ColorAnimation { from: Material.color(18); to: Material.color(0); duration: 2000 }
                    onLoopCountChanged: {

                    }
                }
            }
            GradientStop {
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: Material.color(2); to: Material.color(3); duration: 2000 }
                    ColorAnimation { from: Material.color(3); to: Material.color(4); duration: 2000 }
                    ColorAnimation { from: Material.color(4); to: Material.color(5); duration: 2000 }
                    ColorAnimation { from: Material.color(5); to: Material.color(6); duration: 2000 }
                    ColorAnimation { from: Material.color(6); to: Material.color(7); duration: 2000 }
                    ColorAnimation { from: Material.color(7); to: Material.color(8); duration: 2000 }
                    ColorAnimation { from: Material.color(8); to: Material.color(9); duration: 2000 }
                    ColorAnimation { from: Material.color(9); to: Material.color(10); duration: 2000 }
                    ColorAnimation { from: Material.color(10); to: Material.color(11); duration: 2000 }
                    ColorAnimation { from: Material.color(11); to: Material.color(12); duration: 2000 }
                    ColorAnimation { from: Material.color(12); to: Material.color(13); duration: 2000 }
                    ColorAnimation { from: Material.color(13); to: Material.color(14); duration: 2000 }
                    ColorAnimation { from: Material.color(14); to: Material.color(15); duration: 2000 }
                    ColorAnimation { from: Material.color(15); to: Material.color(16); duration: 2000 }
                    ColorAnimation { from: Material.color(16); to: Material.color(17); duration: 2000 }
                    ColorAnimation { from: Material.color(17); to: Material.color(18); duration: 2000 }
                    ColorAnimation { from: Material.color(18); to: Material.color(0); duration: 2000 }
                    ColorAnimation { from: Material.color(0); to: Material.color(1); duration: 2000 }
                    ColorAnimation { from: Material.color(1); to: Material.color(2); duration: 2000 }
                }
            }
        }
    }
}

