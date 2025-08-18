import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    anchors.fill: parent
    Shape {
        id: svgShape

        // ✅ This is the KEY: scale SVG coordinates to fit parent
        // transform: Scale {
        //     xScale: root.width / 64
        //     yScale: root.height / 64
        // }

        ShapePath {
            strokeColor: Theme.svgColor
            strokeWidth: 2
            fillColor: "transparent"
            scale: Qt.size(root.width / 64, root.height / 64)
            PathSvg {
                path: "M10 4 H54 V55 H10 V4 M18 4 V10 M26 4 V10 M10 16 H53 M34 4 V15 M10 24 H15 M54 24 H48 M54 52 H48"
            }
        }
        ShapePath {
            strokeColor: Theme.svgColor
            strokeWidth: 2
            fillColor: "transparent"
            scale: Qt.size(root.width / 64, root.height / 64)
            PathSvg {
                path: "M32, 24A15.973, 14.473, 0, 0, 0, 21.677, 48l-3.6, 3.6 M22, 48 A14, 14, 0, 1, 0, 32, 24 M22, 48 l4, -4"
            }
        }

        ShapePath {
            strokeColor: Theme.svgColor
            strokeWidth: 2
            fillColor: "transparent"
            scale: Qt.size(root.width / 64, root.height / 64)
            PathSvg {
                path: "M33, 34 A2, 2, 0, 1, 1, 33, 44 A2, 2, 0, 1, 1, 33, 34"
            }
        }
    }
    Text {
        text: "Disk"
        transform: Translate {
            y:-root.height*0.15
        }
        font.pixelSize: Math.min(root.width, root.height) * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        color: Theme.text
    }
}
