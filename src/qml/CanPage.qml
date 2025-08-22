import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import CustomTheme 1.0
import QtQuick.Layouts 1.15

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
