import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 4
            strokeColor: Theme.text
            fillColor: "transparent"
            scale: Qt.size(width / 24, height / 24)
            PathSvg {
                path: "M5.636 5.636a9 9 0 1 0 12.728 0M12 3v9"
            }
        }
    }
}

