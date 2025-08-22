import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

Window {
    id: window
    visible: true
    width: 500
    height: 500
    color: Theme.background

    Rectangle {
        id: topBar
        width: parent.width
        height: parent.height * 0.075
        color: "transparent"
        Component.onCompleted: Theme.current = "dark"

        Text {
            id: titleText
            anchors.centerIn: parent
            text: "Drivers Instrument panel-ATP"
            color: Theme.text
            font.pixelSize: parent.width * 0.03
            anchors.topMargin: 10
            font.bold: true
        }

        PowerOnOff {
            id: poweroff
            anchors.top: parent.top
            anchors.right: parent.right
            height: topBar.height
            width: height
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }

        Dark {
            id: dark
            visible: Theme.current === "light"
            height: topBar.height
            width: height
            anchors.top: parent.top
            anchors.right: poweroff.left
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Theme.current = "dark"
            }
        }

        Light {
            id: light
            visible: Theme.current === "dark"
            height: topBar.height
            width: height
            anchors.top: parent.top
            anchors.right: poweroff.left
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Theme.current = "light"
            }
        }
    }

    Rectangle {
        id: centerWindow
        anchors.top: topBar.bottom
        anchors.topMargin: 10
        anchors.bottom: listView.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"

        SwipeView {
            id: centerListView
            anchors.fill: parent
            onCurrentIndexChanged: {
                listView.currentIndex = centerListView.currentIndex;
                listView.positionViewAtIndex(centerListView.currentIndex, ListView.Center);
            }

            // ✅ Store all page components in a property array
            property var pages: ["MenuPage.qml", "CpuChipPage.qml", "DiskPage.qml", "MemoryPage.qml", "SerialPage.qml", "EthernetPage.qml", "CanPage.qml", "UsbPage.qml", "FunKeyPage.qml", "GlxPage.qml", "TouchPage.qml"]

            Repeater {
                model: centerListView.pages
                Item {
                    width: centerListView.width
                    height: centerListView.height
                    Loader {
                        anchors.fill: parent
                        source: typeof modelData === "string" ? modelData : ""
                        sourceComponent: typeof modelData === "object" ? modelData : null
                    }
                }
            }
        }
    }

    // ===================== Bottom ListView =====================
    ListView {
        id: listView
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        height: window.height * 0.075
        width: window.width / 3
        orientation: ListView.Horizontal
        spacing: 10
        snapMode: ListView.SnapToItem
        highlightMoveDuration: 1500
        highlightMoveVelocity: -1
        boundsBehavior: Flickable.StopAtBounds
        preferredHighlightBegin: width / 2 - 25
        preferredHighlightEnd: width / 2 - 25
        highlightRangeMode: ListView.StrictlyEnforceRange

        model: ["MenuSvg.qml", "CpuChip.qml", "DiskSvg.qml", "Memory.qml", "Serial.qml", "Ethernet.qml", "CanSvg.qml", "Usb.qml", "FuncKey.qml", "Video.qml", "Touch.qml"]

        delegate: Item {
            width: listView.height
            height: listView.height
            opacity: ListView.isCurrentItem ? 1.0 : 0.5
            scale: ListView.isCurrentItem ? 1.5 : 1.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                }
            }

            Loader {
                anchors.fill: parent
                source: modelData
                // sourceComponent: modelData
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    listView.currentIndex = index;
                    listView.positionViewAtIndex(index, ListView.Center);
                    centerListView.currentIndex = index;
                }
            }
        }

        Component.onCompleted: {
            currentIndex = 0;
            positionViewAtIndex(currentIndex, ListView.Center);
        }
    }
}
