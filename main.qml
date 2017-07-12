import QtQuick 2.9
import QtQuick.Window 2.2
import myquickitem 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item {
        anchors.fill: parent
        MyPaintedItem {
            width: parent.width
            height: parent.height
        }
    }
}
