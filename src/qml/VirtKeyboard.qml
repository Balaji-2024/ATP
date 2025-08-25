import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "transparent"
    property var target

    property int keySpacing: 6
    property int sidePadding: 10
    property int keyHeight: 60

    // 🔑 current mode
    property string mode: "letters"   // "letters" | "caps" | "symbols"

    // layouts
    property var rowsLetters: [["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"], ["a", "s", "d", "f", "g", "h", "j", "k", "l"], ["⇧", "z", "x", "c", "v", "b", "n", "m", "⌫"], ["123", ".", " ⟵ ", "space", " ⟶ ", "Enter"]]

    property var rowsSymbols: [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], ["@", "#", "$", "_", "&", "-", "+", "(", ")"], ["ABC", "*", "\"", "'", ";", ":", "!", "?", "⌫"], ["~", "/", " < ", "space", ">", "Enter"]]

    // width multipliers
    property var keyWidthFactors: ({
            "space": 5,
            "Enter": 2,
            "⌫": 2,
            "⇧": 2,
            "123": 2,
            "ABC": 2
            // "🌐": 1.5
        })

    // 🔧 function to switch layouts
    function setMode(newMode) {
        mode = newMode;
    }

    // computed rows based on mode
    property var activeRows: {
        if (mode === "symbols")
            return rowsSymbols;
        else if (mode === "caps")
            return rowsLetters.map(function (row) {
                return row.map(function (key) {
                    return key.length === 1 ? key.toUpperCase() : key;
                });
            });
        else
            return rowsLetters;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: sidePadding
        spacing: keySpacing

        Repeater {
            model: root.activeRows

            delegate: RowLayout {
                spacing: keySpacing
                Layout.fillWidth: true

                property var rowData: modelData

                // per-row unit width
                property real unitWidth: {
                    var totalFactor = 0;
                    for (var i = 0; i < rowData.length; i++) {
                        var key = rowData[i];
                        totalFactor += root.keyWidthFactors[key] || 1;
                    }
                    return (root.width - 2 * sidePadding - (rowData.length - 1) * keySpacing) / totalFactor;
                }

                Repeater {
                    model: rowData
                    delegate: Rectangle {
                        Layout.preferredHeight: keyHeight
                        Layout.fillHeight: true
                        Layout.preferredWidth: unitWidth * (root.keyWidthFactors[modelData] || 1)

                        radius: 8
                        color: Theme.btnColor
                        border.color: Theme.btnBorder

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: Theme.text
                            font.pixelSize: 22
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Pressed:", modelData);

                                if (modelData === "⇧") {
                                    root.setMode(root.mode === "caps" ? "letters" : "caps");
                                } else if (modelData === "123") {
                                    root.setMode("symbols");
                                } else if (modelData === "ABC") {
                                    root.setMode("letters");
                                } else if (modelData === "⌫") {
                                    console.log("Backspace action");
                                } else if (modelData === "Enter") {
                                    console.log("Enter action");
                                } else if (modelData === "space") {
                                    console.log("Space action");
                                } else {
                                    target.appendText(modelData);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
