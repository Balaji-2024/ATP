// EthernetIcon.qml
import QtQuick 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Item {
    id: root
    anchors.fill: parent
    Shape {
        ShapePath {
            strokeWidth: 2
            strokeColor: Theme.text
            fillColor: "transparent"
            // Scale for 24x24 viewBox
            scale: Qt.size(root.width / 24, root.height / 24)
            PathSvg {
                path: "M8 4 H16 V8 H8 Z M12 8 V12 M2 12 H22 M6 12 V16 M18 12 V16 M2 16 H10 V20 H2 Z M14 16 H22 V20 H14 Z"
            }
        }
    }
    Text {
        text: "Ethernet"
        transform: Translate {
            y: -10
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        color: Theme.text
    }
}
