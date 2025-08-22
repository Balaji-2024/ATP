import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

RowLayout {
    id: serialcomproot
    width: parent.width
    height: parent.height
    spacing: 0
    Rectangle {
        Layout.preferredWidth: parent.width * 0.65
        Layout.fillHeight: true
        color: "transparent"
        Flickable {
            id: serialFlick
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: serialTextArea.paintedHeight
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick
            clip: true
            interactive: false

            TextArea {
                id: serialTextArea
                width: parent.width
                readOnly: true
                wrapMode: Text.Wrap
                color: Theme.text

                function appendText(newText) {
                    serialTextArea.text += newText + "\n";
                    serialFlick.contentY = serialFlick.contentHeight - serialFlick.height;
                }
            }
            MouseArea {
                anchors.fill: parent
                drag.target: null

                onPressed: function (mouse) {
                    serialFlick.startX = mouse.x;
                    serialFlick.startY = mouse.y;
                    serialFlick.interactive = true;
                }

                onPositionChanged: function (mouse) {
                    serialFlick.dx = Math.abs(mouse.x - serialFlick.startX);
                    serialFlick.dy = Math.abs(mouse.y - serialFlick.startY);

                    if (serialFlick.dx > serialFlick.dy) {
                        serialFlick.interactive = false; // horizontal swipe → let parent handle
                    } else {
                        serialFlick.interactive = true;  // vertical swipe → Flickable handles
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
                Serial {}
            }
            Rectangle {
                color: "transparent"
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height / 2
                Layout.alignment: Qt.AlignCenter
                GridLayout {
                    id: sergrid
                    anchors.fill: parent
                    columnSpacing: parent.width * 0.1
                    columns: 2
                    Text {
                        text: "Port Name"
                        color: Theme.text
                        font.pixelSize: parent.width * 0.075
                        font.bold: true
                    }
                    ComboBox {
                        id: portName
                        padding: 10
                        model: ["/dev/ttyS0", "/dev/ttyS1", "/dev/ttyS2", "/dev/ttyUSB0", "/dev/ttyUSB1"]
                        currentIndex: 0
                        width: sergrid.width * 0.5
                        height: sergrid.height * 0.25
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 10
                            color: Theme.btnColor
                            border.color: "#0d47a1"
                            border.width: 2
                        }
                        contentItem: Text {
                            anchors.centerIn: parent
                            text: portName.currentText
                            color: Theme.text
                            rightPadding: 10
                            font.pixelSize: sergrid.width * 0.05
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                    }
                    Text {
                        text: "Baud Rate"
                        color: Theme.text
                        font.pixelSize: parent.width * 0.075
                        font.bold: true
                    }
                    ComboBox {
                        id: baudRate
                        padding: 10
                        width: sergrid.width * 0.5
                        height: sergrid.height * 0.25
                        model: ["9600", "19200", "38400", "57600", "115200"]
                        currentIndex: 0

                        // Background
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 10
                            color: Theme.btnColor
                            border.color: "#0d47a1"
                            border.width: 2
                        }

                        contentItem: Text {
                            anchors.centerIn: parent
                            text: baudRate.currentText
                            rightPadding: 10
                            color: Theme.text
                            font.pixelSize: sergrid.width * 0.05
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }

                        // Popup
                        popup: Popup {
                            // y: baudRate.height
                            width: baudRate.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 5
                            font.pixelSize: baudRate.contentItem.font.pixelSize

                            background: Rectangle {
                                radius: 8
                                color: Theme.btnColor
                                border.color: "#0d47a1"
                                border.width: 2
                            }

                            contentItem: ListView {
                                clip: true
                                // font.pixelSize: sergrid.width * 0.05
                                model: baudRate.delegateModel
                                currentIndex: baudRate.highlightedIndex
                                implicitHeight: contentHeight
                                // maximumHeight: baudRate.height * 5
                                ScrollIndicator.vertical: ScrollIndicator {}
                            }
                        }
                    }

                    Button {
                        id: serialTestButton
                        padding: 10
                        Layout.columnSpan: 2
                        Layout.alignment: Qt.AlignHCenter
                        width: sergrid.width * 0.6      // 🔑 set button width
                        height: sergrid.height * 0.3    // 🔑 set button height

                        background: Rectangle {
                            anchors.fill: parent        // 🔑 background fills button area
                            radius: 10
                            color: Theme.btnColor
                            border.color: "#0d47a1"
                            border.width: 2
                        }

                        contentItem: Text {
                            anchors.centerIn: parent
                            text: "Test Serial"
                            color: Theme.text
                            font.pixelSize: sergrid.width * 0.05
                            font.bold: true
                        }
                        onClicked: {
                            console.log("Serial Port: " + portName.currentText + ", Baud Rate: " + baudRate.currentText);
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
