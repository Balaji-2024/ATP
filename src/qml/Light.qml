import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
// optional, for advanced vector drawing
import CustomTheme 1.0

Item {
    Shape {
        anchors.fill: parent
        ShapePath {
            strokeWidth: 1
            strokeColor: Theme.text
            fillColor: Theme.text
            scale: Qt.size(width / 24, height / 24)
            PathSvg {
                path: "M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z"
            }
        }
    }
}
