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
            id: mptArea

            signal twoFingersPressed()
            anchors.fill: parent
            mouseEnabled: false
            minimumTouchPoints: 2
            maximumTouchPoints: 2
            touchPoints: [
                TouchPoint {
                    id: tp1
                },
                TouchPoint {
                    id: tp2
                }
            ]
            onPressed: mptTimer.start()

            Timer {
                id: mptTimer
                interval: 100
                onTriggered: if (!pinchArea.pinching) mptArea.twoFingersPressed()
            }

            PinchArea {
                id: pinchArea

                property bool pinching
                anchors.fill: parent

                onPinchStarted: pinching = true
                onPinchFinished: pinching = false

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                }

                MouseArea {
                    id: swipeArea
                    anchors.fill: parent
                    property real prevX: 0
                    property real velocityX: 0.0
                    property int startX: 0
                    property bool tracing: false
                    property bool swipedLeft: false
                    property bool swipedRight: false

                    signal swipeLeft()
                    signal swipeRight()

                    propagateComposedEvents: true

                    onPressed: {
                        startX = mouse.x
                        prevX = mouse.x
                        velocityX = 0
                        tracing = true
                    }
                    onClicked: {
                        mouse.accepted = swipedLeft || swipedRight
                        swipedLeft = swipedRight = false
                    }

                    onPositionChanged: {
                        if ( !tracing ) return
                        var currVelX = (mouse.x-prevX)

                        velocityX = (velocityX + currVelX)/2.0;

                        prevX = mouse.x

                        if ( velocityX > 10 && mouse.x > width * 0.25 ) {
                            tracing = false
                            swipeRight()
                            swipedRight = true
                        } else if ( velocityX < -10 && mouse.x < width * 0.75 ) {
                            tracing = false
                            swipeLeft()
                            swipedLeft = true
                        }
                    }
                }
            }
        }
    }
    Text {
        id: textBox
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Connections {
            target: mouseArea
            onClicked: {print("touch");textBox.text = "touch";timer.start()}
            onPressAndHold: {print("long touch");textBox.text = "long touch";timer.start()}
        }
        Connections {
            target: swipeArea
            onSwipeLeft: {print("swipe left");textBox.text = "swipe left";timer.start()}
            onSwipeRight: {print("swipe right");textBox.text = "swipe right";timer.start()}
        }
        Connections {
            target: pinchArea
            onPinchStarted: {print("pinch");textBox.text = "pinch";timer.start()}
        }
        Connections {
            target: mptArea
            onTwoFingersPressed: {print("two-finger touch");textBox.text = "two-finger touch";timer.start()}
        }

        Timer {
            id: timer
            interval: 1000
            onTriggered: textBox.text = ""
        }
    }
}
