// Theme.qml
pragma Singleton
import QtQuick 2.15
import QtQuick.Controls 2.15

QtObject {
    // Theme name: "light", "dark", "solarized", etc.
    property string current: "light"

    // All theme definitions in one place
    readonly property var themes: {
        "light": {
            text: "0e0f2d",
            background: "white",
            accent: "blue"
        },
        "dark": {
            text: "white",
            background: "#121212",
            accent: "cyan"
        },
        "solarized": {
            text: "#839496",
            background: "#002b36",
            accent: "#b58900"
        }
    }

    // Accessors (auto-resolve from current theme)
    readonly property color text: themes[current].text
    readonly property color background: themes[current].background
    readonly property color accent: themes[current].accent

    // Fonts
    property string fontFamily: "Sans Serif"
    property int fontSize: 14
}
