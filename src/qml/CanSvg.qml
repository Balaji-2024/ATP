import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    anchors.fill: parent
    Shape {
        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.svgColor
            fillColor: Theme.svgColor
            scale: Qt.size(width / 512.275, height / 512.275)
            PathSvg {
                path: "M70,70 a30,30 0 1,0 0.1,0Z M70,190 a30,30 0 1,0 0.1,0 Z M450,250 a30,30 0 1,0 0.1,0Z M450,380 a30,30 0 1,0 0.1,0Z "
            }
        }
        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.svgColor
            fillColor: "transparent"
            scale: Qt.size(width / 512.275, height / 512.275)
            PathSvg {
                path: "M90,100 h156 a30,30 0 0,1 30,30 v120 a30,30 0 0,0 30,30 h120"
            }
        }
        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.svgColor
            fillColor: "transparent"
            scale: Qt.size(width / 512.275, height / 512.275)
            PathSvg {
                path: "M90,220 h156 a30,30 0 0,1 30,30 v130 a30,30 0 0,0 30,30 h120"
            }
        }
    }
    Text {
        text: "CAN"
        transform: Translate {
            y: -10
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        color: Theme.text
    }
}
