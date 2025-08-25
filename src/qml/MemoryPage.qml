import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

RowLayout {
    id: memoryRoot
    width: parent.width
    height: parent.height
    spacing: 0
    anchors.horizontalCenter: parent.horizontalCenter
    Rectangle {
        Layout.preferredWidth: parent.width * 0.75
        Layout.fillHeight: true
        color: "transparent"
        Flickable {
            id: memFlick
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: memTextArea.paintedHeight
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick
            clip: true
            interactive: false

            TextArea {
                id: memTextArea
                width: parent.width
                readOnly: true
                wrapMode: Text.Wrap
                color: Theme.text

                function appendText(newText) {
                    memTextArea.text += newText + "\n";
                    memFlick.contentY = memFlick.contentHeight - memFlick.height;
                }
            }
            MouseArea {
                anchors.fill: parent
                drag.target: null

                onPressed: function (mouse) {
                    memFlick.startX = mouse.x;
                    memFlick.startY = mouse.y;
                    memFlick.interactive = true;
                }

                onPositionChanged: function (mouse) {
                    memFlick.dx = Math.abs(mouse.x - memFlick.startX);
                    memFlick.dy = Math.abs(mouse.y - memFlick.startY);

                    if (memFlick.dx > memFlick.dy) {
                        memFlick.interactive = false; // horizontal swipe → let parent handle
                    } else {
                        memFlick.interactive = true;  // vertical swipe → Flickable handles
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
        Layout.preferredWidth: parent.width * 0.24
        Layout.preferredHeight: parent.height * 0.65
        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            Rectangle {
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2
                Memory {}
            }
            Rectangle {
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2
                Text {
                    text: "Memory Information"
                    color: Theme.text
                    font.pixelSize: parent.width * 0.1
                    font.bold: true
                    anchors.centerIn: parent
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (appInterface) {
                                memTextArea.appendText(appInterface.memInfo());
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
