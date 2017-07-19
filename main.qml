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

        PinchArea {
            id: pinchArea
            anchors.fill: parent
        }
        MouseArea {
            id: mouseSwipeArea
            objectName: "mouseSwipeArea"
            anchors.fill: parent
            scrollGestureEnabled: false

            property real prevX: 0
            property real prevY: 0
            property real velocityX: 0.0
            property real velocityY: 0.0
            property int startX: 0
            property int startY: 0
            property bool tracing: false

            signal swipeLeft()
            signal swipeRight()
            signal swipeUp()
            signal swipeDown()

            onPressed: {
                startX = mouse.x
                startY = mouse.y
                prevX = mouse.x
                prevY = mouse.y
                velocityX = 0
                velocityY = 0
                tracing = true
            }

            onPositionChanged: {
                if ( !tracing ) return
                var currVelX = (mouse.x-prevX)
                var currVelY = (mouse.y-prevY)

                velocityX = (velocityX + currVelX)/2.0;
                velocityY = (velocityY + currVelY)/2.0;

                prevX = mouse.x
                prevY = mouse.y

                if ( velocityX > 15 && mouse.x > mouseSwipeArea.width * 0.25 ) {
                    tracing = false
                    // Swipe Right
                    mouseSwipeArea.swipeRight()
                } else if ( velocityX < -15 && mouse.x < mouseSwipeArea.width * 0.75 ) {
                    tracing = false
                    // Swipe Left
                    mouseSwipeArea.swipeLeft()
                } else if (velocityY > 15 && mouse.y > mouseSwipeArea.height * 0.25 ) {
                    tracing = false
                    // Swipe Down
                    mouseSwipeArea.swipeDown()
                } else if ( velocityY < -15 && mouse.y < mouseSwipeArea.height * 0.75 ) {
                    tracing = false
                    // Swipe Up
                    mouseSwipeArea.swipeUp()
                }
            }
        }
    }

    Text {
        id: textBox
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Connections {
            target: mouseSwipeArea
            onClicked: {textBox.text = "touch";timer.start()}
            onPressAndHold: {textBox.text = "long touch";timer.start()}
            onSwipeLeft: {textBox.text = "swipe left";timer.start()}
            onSwipeRight: {textBox.text = "swipe right";timer.start()}
        }
        Connections {
            target: pinchArea
            onPinchFinished: {textBox.text = "pinch";timer.start()}
        }
        Timer {
            id: timer
            interval: 1000
            onTriggered: textBox.text = ""
        }
    }
}
