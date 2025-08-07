import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    anchors.fill: parent
    Shape {
        ShapePath {
            strokeWidth: 4
            strokeColor: ctheme === "light" ? Theme.lightThemeText : Theme.darkThemeText
            fillColor: "transparent"
            scale: Qt.size(width / 24, height / 24)
            PathSvg {
                path: "M8.25 3v1.5M4.5 8.25H3m18 0h-1.5M4.5 12H3m18 0h-1.5m-15 3.75H3m18 0h-1.5M8.25 19.5V21M12 3v1.5m0 15V21m3.75-18v1.5m0 15V21m-9-1.5h10.5a2.25 2.25 0 0 0 2.25-2.25V6.75a2.25 2.25 0 0 0-2.25-2.25H6.75A2.25 2.25 0 0 0 4.5 6.75v10.5a2.25 2.25 0 0 0 2.25 2.25Zm.75-12h9v9h-9v-9Z"
            }
        }
    }
}
