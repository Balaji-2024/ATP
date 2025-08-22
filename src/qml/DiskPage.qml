import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

RowLayout {
    id: diskcomproot
    width: parent.width
    height: parent.height
    spacing: 0
    Rectangle {
        Layout.preferredWidth: parent.width * 0.65
        Layout.fillHeight: true
        color: "transparent"
        Flickable {
            id: diskFlick
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: diskTextArea.paintedHeight
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick
            clip: true
            interactive: false

            TextArea {
                id: diskTextArea
                width: parent.width
                readOnly: true
                wrapMode: Text.Wrap
                color: Theme.text

                function appendText(newText) {
                    diskTextArea.text += newText + "\n";
                    diskFlick.contentY = diskFlick.contentHeight - diskFlick.height;
                }
            }
            MouseArea {
                anchors.fill: parent
                drag.target: null

                onPressed: function (mouse) {
                    diskFlick.startX = mouse.x;
                    diskFlick.startY = mouse.y;
                    diskFlick.interactive = true;
                }

                onPositionChanged: function (mouse) {
                    diskFlick.dx = Math.abs(mouse.x - diskFlick.startX);
                    diskFlick.dy = Math.abs(mouse.y - diskFlick.startY);

                    if (diskFlick.dx > diskFlick.dy) {
                        diskFlick.interactive = false; // horizontal swipe → let parent handle
                    } else {
                        diskFlick.interactive = true;  // vertical swipe → Flickable handles
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
                DiskSvg {}
            }
            Rectangle {
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2
                Text {
                    text: "Disk Information"
                    color: Theme.text
                    font.pixelSize: parent.width * 0.1
                    font.bold: true
                    anchors.centerIn: parent
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (appInterface) {
                                diskTextArea.appendText(appInterface.diskInfo());
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
