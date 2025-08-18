// SerialIcon.qml
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
            fillColor: "transparent"
            // Scale for 24x24 viewBox
            scale: Qt.size(root.width / 24, root.height / 24)
            PathSvg {
                path: "
                M7 10.75 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M9.5 10.75 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M12 10.75 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M14.5 10.75 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M17 10.75 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M8.25 13.25 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M10.75 13.25 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M13.25 13.25 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M15.75 13.25 m -0.6, 0
                a 0.6, 0.6 0 1, 0 1.2, 0
                a 0.6, 0.6 0 1, 0 -1.2, 0

                M4.90701 6.99933C3.13073 6.99933 1.82042 8.65816 2.23177 10.3862L3.30329 14.8875C3.5982 16.1263 4.70507 17.0007 5.97854 17.0007H18.0172C19.2901 17.0007 20.3966 16.1271 20.6921 14.889L21.7664 10.3877C22.1789 8.65932 20.8685 6.99933 19.0915 6.99933H4.90701Z"
            }
        }
    }
    Text {
        text: "Serial"
        transform: Translate {
            y:-root.height*0.20
        }
        font.pixelSize: Math.min(root.width, root.height) * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        color: Theme.text
    }
}
