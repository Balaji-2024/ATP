import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

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

                function appendText(newText) {
                    cpuTextArea.text += newText + "\n";
                    cpuFlick.contentY = cpuFlick.contentHeight - cpuFlick.height;
                }
            }
            MouseArea {
                anchors.fill: parent
                drag.target: null

                onPressed: function (mouse) {
                    cpuFlick.startX = mouse.x;
                    cpuFlick.startY = mouse.y;
                    cpuFlick.interactive = true;
                }

                onPositionChanged: function (mouse) {
                    cpuFlick.dx = Math.abs(mouse.x - cpuFlick.startX);
                    cpuFlick.dy = Math.abs(mouse.y - cpuFlick.startY);

                    if (cpuFlick.dx > cpuFlick.dy) {
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
                            if (appInterface) {
                                cpuTextArea.appendText(appInterface.cpuInfo());
                            } else {
                                console.log("interfaceObj is undefined");
                            }
                        }
                    }
                }
            }
        }
    }
    Item {
        Layout.preferredWidth: parent.width * 0.01
    }
}
