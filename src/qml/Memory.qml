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
            scale: Qt.size(width / 64, height / 64)
            PathSvg {
                path: "M20, 50h4v4h-4zM28, 50h16v4H28zM32, 38a8, 8, 0, 1, 0-8-8a8, 8, 0, 0, 0, 8, 8zM12, 6H44M8, 6h4V16a2, 2, 0, 0, 0, 2, 2H41a2, 2, 0, 0, 0, 2-2V6h3.172L56, 15.829V58H52V44a2, 2, 0, 0, 0-2-2H14a2, 2, 0, 0, 0-2, 2V58H8zM10, 58H52 M36 6 V14"
            }

        }
    }
}
