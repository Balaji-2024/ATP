import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    // Must be passed from parent
    property string ctheme: "light"

        Shape {
            anchors.fill: parent

            ShapePath {
                strokeWidth: 4
                strokeColor: ctheme === "light" ? Theme.lightThemeText : Theme.darkThemeText
                fillColor: "transparent"
                scale: Qt.size(width / 64, height / 64)

            }
        }
    }
