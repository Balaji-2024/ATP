import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    width: 100
    height: 100
    Shape {
        anchors.fill: parent
        transform: Scale {
            xScale: root.width / 24
            yScale: root.height / 24
        }
        ShapePath {
            strokeWidth: 2
            strokeColor: "transparent"
            fillColor: "red"
            // scale: Qt.size(width / 24, height / 24)
            PathSvg {
                path: "M12 4a8 8 0 1 0 0.0001 0 Z"
            }
        }
        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.text
            fillColor: "transparent"
            // scale: Qt.size(width / 24, height / 24)
            PathSvg {

                path: "M5.636 5.636a9 9 0 1 0 12.728 0M12 3v9"
            }
        }
    }
}
