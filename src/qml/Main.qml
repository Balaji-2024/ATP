import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0

Window {
    id:window
    visible: true
    width: 500
    height: 500
    visibility: "FullScreen"
    flags: Qt.FramelessWindowHint
    property string theme: "light"
        Rectangle {
            anchors.fill: parent
            Component.onCompleted: Theme.current = "dark"
            color: Theme.background
            // Toggle to Dark Mode
            Dark {
                id: dark
                width: 100
                height: 100
                visible: Theme.current === "light"  // show dark icon in light mode
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
                visible: Theme.current === "dark"  // show light icon in dark mode
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.right: poweroff.left
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Theme.current = "light"
                }
            }
            PowerOnOff {
                id: poweroff
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.right: parent.right
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.quit()
                }
            }
        }
    }
