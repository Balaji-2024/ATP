import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

Rectangle {
    anchors.fill: parent
    color: "transparent"
    Image {
        id: parasLogo
        source: "qrc:/png/assets/paras_logo.png"
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width * 0.25
        height: parent.height * 0.25
        scale: 1.5
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: cvrdeLogo
        source: "qrc:/png/assets/CVRDE_LOGO.png"
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width * 0.20
        height: parent.height * 0.20
        fillMode: Image.PreserveAspectFit
    }

    GridLayout {
        id: grid
        width: parent.width * 0.6
        height: parent.height * 0.6
        anchors.centerIn: parent
        rowSpacing: parent.height * 0.015
        columnSpacing: rowSpacing
        columns: 4

        Repeater {
            model: ["MenuSvg.qml", "CpuChip.qml", "DiskSvg.qml", "Memory.qml", "Serial.qml", "Ethernet.qml", "CanSvg.qml", "Usb.qml", "FuncKey.qml", "Video.qml", "Touch.qml"]

            delegate: Item {
                Layout.preferredWidth: grid.width / 4 - grid.columnSpacing
                Layout.preferredHeight: Math.min(width, grid.height / 4 - grid.rowSpacing)

                Loader {
                    anchors.fill: parent
                    source: modelData
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: centerListView.currentIndex = index
                }
            }
        }
    }
}
