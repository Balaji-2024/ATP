// GlxgearsItem.qml
import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    id: glxgearsWrapper
    width: 300
    height: 300

    property int glxgearsWinId: -1

    Component.onCompleted: {
        // Launch glxgears in background
        Qt.callLater(function () {
            // Run glxgears in background
            Qt.createQmlObject(`import QtQuick 2.15; QtObject { Component.onCompleted: {
                    var proc = Qt.createQmlObject(
                        'import QtQuick 2.15; QtObject {}',
                        glxgearsWrapper);
                    proc.process = Qt.createQmlObject(
                        'import QtQuick 2.15; QtObject {}',
                        glxgearsWrapper);
                    proc.process = new QProcess();
                    proc.process.start("glxgears");
                } }`, glxgearsWrapper);
        });

        // Wait a moment and get X11 window ID (must be customized)
        Qt.callLater(function () {
            var pidCmd = "pgrep glxgears";
            var pid = getCommandOutput(pidCmd).trim();

            if (pid !== "") {
                var winIdCmd = `xdotool search --pid ${pid}`;
                var winId = getCommandOutput(winIdCmd).split("\n")[0];
                glxgearsWrapper.glxgearsWinId = parseInt(winId);
                embedExternalWindow(glxgearsWrapper.glxgearsWinId);
            }
        });
    }

    function getCommandOutput(cmd) {
        var result = "";
        var proc = new QProcess();
        proc.start("/bin/sh", ["-c", cmd]);
        proc.waitForFinished();
        result = proc.readAllStandardOutput();
        return result;
    }

    function embedExternalWindow(winId) {
        // Requires C++ integration to use QWindow::fromWinId(winId)
        console.log("Embed external window with winId:", winId);
    // You must implement the actual embedding in C++
    }
}
