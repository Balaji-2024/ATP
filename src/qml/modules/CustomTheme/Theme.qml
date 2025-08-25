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
            text: "#161200",
            background: "#e2c471",
            svgColor: "#ea3d2f01",
            btnColor: "#f3f3f3",
            btnBorder: "#0d47a1",
            accent: "blue"
        },
        "dark": {
            text: "#a5a6d6",
            background: "#120f27",
            svgColor: "#c0a343",
            btnColor: "#6b6650f3",
            btnBorder: "#0d47a1",
            accent: "cyan"
        },
        "solarized": {
            text: "#839496",
            background: "#002b36",
            svgColor: "#eeba10",
            accent: "#b58900"
        }
    }

    // Accessors (auto-resolve from current theme)
    readonly property color text: themes[current].text
    readonly property color background: themes[current].background
    readonly property color svgColor: themes[current].svgColor
    readonly property color accent: themes[current].accent
    readonly property color btnColor: themes[current].btnColor
    readonly property color btnBorder: themes[current].btnBorder

    // Fonts
    property string fontFamily: "Sans Serif"
    property int fontSize: 14
}
