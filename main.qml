import QtQuick 2.9
import QtQuick.Window 2.2
import myquickitem 1.0

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MyQuickItem {
        id: item
        width: window.width
        height: window.height

        MultiPointTouchArea {
            id: mptAreaDouble
            objectName: "mtpAreaDouble"
            signal pinched()
            signal twoFingered()
            anchors.fill: parent
            touchPoints: [
                TouchPoint {id: point1},
                TouchPoint {id: point2}
            ]
            minimumTouchPoints: 2
            maximumTouchPoints: 2
            onPressed: mptAreaSingle.enabled = false
            onReleased: {
                if (point1.previousX !== point1.x
                        && point2.previousX !== point2.x) {
                    pinched()
                } else {
                    twoFingered()
                }
                stimer.restart()
            }
            MouseArea {
                id: mptAreaSingle
                objectName: "mtpAreaSingle"
                anchors.fill: parent
                scrollGestureEnabled: false
            }
            Timer {
                id: stimer
                interval: 1200
                onTriggered: mptAreaSingle.enabled = true
            }
        }
    }

    Text {
        id: textBox
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Connections {
            target: mptAreaSingle
            onClicked: {textBox.text = "touch";timer.start()}
            onPressAndHold: {textBox.text = "long touch";timer.start()}
        }
        Connections {
            target: mptAreaDouble
            onTwoFingered: {textBox.text = "two finger touch";timer.start()}
            onPinched: {textBox.text = "pinch";timer.start()}
        }
        Timer {
            id: timer
            interval: 1000
            onTriggered: textBox.text = ""
        }
    }
}
