import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        RowLayout {
            id: row
            Layout.preferredHeight: root.height * 0.2 // 👈 Dynamic height
            Layout.fillWidth: true
            Layout.margins: 5
            spacing: 10
            Rectangle {
                id: ipText
                Layout.fillWidth: true
                Layout.preferredHeight: row.height * 0.8
                color: "lightblue"
                border.color: "black"
                Text {
                    id: ipTextDisplay
                    anchors.centerIn: parent
                    text: ""
                    color: "black"
                    font.pixelSize: Math.min(ipText.width) * 0.12 // auto-scaling
                }
            }
            ComboBox {
                id: intervalCombo
                model: [5, 10, 15, 20]
                Layout.preferredHeight: row.height * 0.8
                Layout.preferredWidth: root.width * 0.15
                background: Rectangle {
                    color: "lightgreen"
                    border.color: "black"
                    radius: 4
                }
                contentItem: Text {
                    text: intervalCombo.currentText
                    anchors.centerIn: parent
                    font.pixelSize: Math.min(parent.width, row.height) * 0.5
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                }
            }
            Rectangle {
                id: pingText
                Layout.preferredHeight: row.height * 0.8
                Layout.preferredWidth: root.width * 0.15
                color: "lightgreen"
                border.color: "black"
                radius: 4
                Text {
                    anchors.centerIn: parent
                    text: "Ping"
                    font.pixelSize: Math.min(parent.width, parent.height) * 0.5
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: ipTextDisplay.text = ""
                }
            }
        }
        GridLayout {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 3
            columnSpacing: 5
            rowSpacing: 5
            Layout.margins: 5
            Layout.alignment: Qt.AlignCenter
            Repeater {
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "<-"]
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "blue"
                    radius: 5
                    border.color: "black"
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        font.pixelSize: Math.min(parent.width, parent.height) * 0.4
                        color: "white"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (modelData === "<-")
                                ipTextDisplay.text = ipTextDisplay.text.slice(0, -1);
                            else if (ipTextDisplay.text.length < 15)
                                ipTextDisplay.text += modelData;
                        }
                    }
                }
            }
        }
    }
}
