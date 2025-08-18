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
            property var pages: [centerMenuComponent, centerCpuChipComponent, centerMemoryComponent, centerDiskComponent, centerSerialComponent, centerCanComponent, centerVideoComponent, centerEthernetComponent, centerUsbComponent]

            Repeater {
                model: centerListView.pages
                Item {
                    width: centerListView.width
                    height: centerListView.height
                    Loader {
                        anchors.fill: parent
                        sourceComponent: modelData
                    }
                }
            }
        }
    }

    // ===================== Components =====================
    Component {
        id: centerMenuComponent
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
                rowSpacing: parent.height * 0.025
                columnSpacing: rowSpacing
                columns: 3

                Repeater {
                    model: [menuComponent, cpuChipComponent, memoryComponent, diskComponent, serialComponent, canComponent, videoComponent, ethernetComponent, usbComponent]
                    delegate: Item {
                        Layout.preferredWidth: grid.width / 3 - grid.columnSpacing
                        Layout.preferredHeight: grid.height / 3 - grid.rowSpacing

                        Loader {
                            anchors.fill: parent
                            sourceComponent: modelData
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
    }

    Component {
        id: centerCpuChipComponent
        RowLayout {
            id: root
            width: parent.width
            height: parent.height
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                Layout.preferredWidth: parent.width * 0.65
                Layout.fillHeight: true
                color: "transparent"
                Flickable {
                    id: cpuFlick
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: cpuTextArea.paintedHeight
                    boundsBehavior: Flickable.StopAtBounds
                    flickableDirection: Flickable.VerticalFlick
                    clip: true
                    interactive: false

                    TextArea {
                        id: cpuTextArea
                        width: parent.width
                        readOnly: true
                        wrapMode: Text.Wrap
                        color: Theme.text

                        function appendText(newText)
                        {
                            cpuTextArea.text += newText + "\n";
                            cpuFlick.contentY = cpuFlick.contentHeight - cpuFlick.height;
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        drag.target: null

                        onPressed: function(mouse) {
                        cpuFlick.startX = mouse.x;
                        cpuFlick.startY = mouse.y;
                        cpuFlick.interactive = true;
                    }

                    onPositionChanged: function(mouse) {
                    cpuFlick.dx = Math.abs(mouse.x - cpuFlick.startX);
                    cpuFlick.dy = Math.abs(mouse.y - cpuFlick.startY);

                    if (cpuFlick.dx > cpuFlick.dy)
                    {
                        cpuFlick.interactive = false; // horizontal swipe → let parent handle
                    } else {
                    cpuFlick.interactive = true;  // vertical swipe → Flickable handles
                }
            }
        }

        property real startX: 0
            property real startY: 0
                property real dx: 0
                    property real dy: 0


                    }
                }
                Rectangle {
                    color: "transparent"
                    Layout.preferredWidth: parent.width * 0.34
                    Layout.preferredHeight: parent.height * 0.65
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 10
                        Rectangle {
                            color: "transparent"
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height / 2
                            CpuChip {}
                        }
                        Rectangle {
                            color: "transparent"
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height / 2
                            Text {
                                text: "CPU Information"
                                color: Theme.text
                                font.pixelSize: parent.width * 0.1
                                font.bold: true
                                anchors.centerIn: parent
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        if (appInterface)
                                        {
                                            appInterface.cpuInfo();
                                        } else {
                                        console.log("interfaceObj is undefined");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Component.onCompleted: {
                // Connect the C++ signal to a JS function
                appInterface.cpuInfoUpdated.connect(function (cpuStr) {
                cpuTextArea.appendText(cpuStr);
            });
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}

Component {
    id: centerMemoryComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            Memory {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerDiskComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            DiskSvg {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerSerialComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            Serial {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerCanComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            CanSvg {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerVideoComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            Video {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerEthernetComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            Ethernet {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
        }
    }
}
Component {
    id: centerUsbComponent
    RowLayout {
        width: parent.width
        height: parent.height
        Rectangle {
            Layout.preferredWidth: parent.width * 0.65
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.preferredWidth: parent.width * 0.34
            Layout.preferredHeight: parent.height * 0.65
            color: "transparent"
            Usb {}
        }
        Item {
            Layout.preferredWidth: parent.width * 0.01
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

    model: [menuComponent, cpuChipComponent, memoryComponent, diskComponent, serialComponent, canComponent, videoComponent, ethernetComponent, usbComponent]

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
    sourceComponent: modelData
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

// ===================== Mini components for Loader in ListView =====================
Component {
    id: menuComponent
    MenuSvg {}
}
Component {
    id: cpuChipComponent
    CpuChip {}
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
    id: canComponent
    CanSvg {}
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
}
