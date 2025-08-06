import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Window {
    id: window
    visible: true
    width: 500
    height: 500
    // visibility: "FullScreen"
    // flags: Qt.FramelessWindowHint
    color: Theme.background
    Rectangle {
        id: topBar
        width: parent.width
        height: 35
        anchors.right: parent.right
        Component.onCompleted: Theme.current = "dark"
        color: "transparent"
        PowerOnOff {
            id: poweroff
            anchors.top: parent.top
            anchors.right: parent.right
            width: 35
            height: 35
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }
        // Toggle to Dark Mode
        Dark {
            id: dark
            visible: Theme.current === "light" // show dark icon in light mode
            width: 35
            height: 35
            anchors.top: parent.top
            anchors.right: poweroff.left
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Theme.current = "dark"
            }
        }
        // Toggle to Light Mode
        Light {
            id: light
            visible: Theme.current === "dark" // show light icon in dark mode
            width: 35
            height: 35
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
        anchors.bottom: listView.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"
        ListView {
            id: centerListView
            anchors.fill: parent
            orientation: ListView.Horizontal
            spacing: 0
            snapMode: ListView.SnapOneItem
            highlightMoveDuration: 800
            highlightMoveVelocity: -1
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightRangeMode: ListView.StrictlyEnforceRange

            model: [menuComponent, memoryComponent, diskComponent, serialComponent, videoComponent, ethernetComponent, usbComponent, keypadComponent]

            delegate: Item {
                id: centerDelegateItem
                width: centerListView.width     // ✅ Full screen width
                height: centerListView.height   // ✅ Full screen height
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
                    sourceComponent: modelData  // ✅ OK here, inside Loader
                }
            }

            Component {
                id: centerMenuComponent
                MenuSvg {}
            }
            Component {
                id: centerMemoryComponent
                Memory {}
            }
            Component {
                id: centerDiskComponent
                DiskSvg {}
            }
            Component {
                id: centerSerialComponent
                Serial {}
            }
            Component {
                id: centerVideoComponent
                Video {}
            }
            Component {
                id: centerEthernetComponent
                Ethernet {}
            }
            Component {
                id: centerUsbComponent
                Usb {}
            }
            Component {
                id: keypadComponent
                Keypad {}
            }
        }
    }
    ListView {
        id: listView
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        height: 50
        width: parent.width / 4
        orientation: ListView.Horizontal
        spacing: 5
        snapMode: ListView.SnapToItem
        highlightMoveDuration: 800
        highlightMoveVelocity: -1
        boundsBehavior: Flickable.StopAtBounds
        preferredHighlightBegin: width / 2 - 25
        preferredHighlightEnd: width / 2 - 25
        highlightRangeMode: ListView.StrictlyEnforceRange

        model: [menuComponent, memoryComponent, diskComponent, serialComponent, videoComponent, ethernetComponent, usbComponent]

        delegate: Item {
            id: delegateItem
            width: 50
            height: 50
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
                sourceComponent: modelData  // ✅ OK here, inside Loader
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

        Component {
            id: menuComponent
            MenuSvg {}
        }
        Component {
            id: memoryComponent
            Memory {}
        }
        Component {
            id: diskComponent
            DiskSvg {}
        }
        Component {
            id: serialComponent
            Serial {}
        }
        Component {
            id: videoComponent
            Video {}
        }
        Component {
            id: ethernetComponent
            Ethernet {}
        }
        Component {
            id: usbComponent
            Usb {}
        }
        Component.onCompleted: {
            currentIndex = Math.floor(model.length / 2);
            positionViewAtIndex(currentIndex, ListView.Center);
        }
    }
}
