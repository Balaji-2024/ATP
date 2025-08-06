import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    // Must be passed from parent
    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.text
            fillColor: "transparent"
            scale: Qt.size(width / 24, height / 24)
            PathSvg {
                path: "M5 10 V2 H19 V10 H21 V20 H5 V20 H3 V10 H5 M7 10 H17 V4 H7 V10 M9 6 H11 V8 H9 V6 M13 6 H15 V8 H13 V6"
            }
        }
    }
}
