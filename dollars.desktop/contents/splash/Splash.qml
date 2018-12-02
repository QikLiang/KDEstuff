import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0

Rectangle {
    id: root
    color: "#010101"
    
    property int stage//: 6//fakeStage.val
    
    onStageChanged: {
        if (stage ==1) {
            first.visible = true
        } else if (stage == 2) {
            //show(second)
        }
    }
    
    Rectangle { //white region at top]
        id: commentRegion
        color: "#FAFAFA"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 135
        
        Rectangle { //comment text box
            id: commentBox
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.18
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            
            height: 80
            
            color: "#FAFAFA"
            border.color: "#989898"
            border.width: 2
            radius: 10
            
            //blinking cursor
            Rectangle {
                id: cursor
                width: 2
                height: 25
                border.width: 1
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Timer{
                running: true
                repeat: true
                interval: 1000
                onTriggered: cursor.visible = !cursor.visible
            }
        }
        
        Rectangle { //post button
            id: postButton
            anchors.top : commentBox.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            
            width: 250
            height: 35
            
            //create gradiant effect
            color: "#f1efea"
            Item {
                anchors.fill: parent
                
                layer.enabled: true //copied from https://stackoverflow.com/questions/39455806/clip-children-of-custom-qml-item-after-custom-shape
                layer.effect: OpacityMask {
                    maskSource: parent
                }
                
                Rectangle {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: parent.height / 2
                    
                    color: "#f9f9f9"
                }
            }
            
            Text {
                text: "POST!"
                color: "black"
                font.pixelSize: 16
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            
            //border that goes over the gradiant
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: "#817c7d"
                border.width: 3
                radius: 13
            }
        } //close post button
    } //close comment box

    
    //comments
    ColumnLayout {
        spacing: 30
        anchors.top: commentRegion.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.07
        
        Item {
            visible: root.stage >= 6
            height: 80
            
            Image {
                source: "kuru_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "kuru_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation { //delay animation so it occurs after
                        PauseAnimation { duration: 500 }//visible is true
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        
        Item {
            visible: root.stage >= 5
            height: 80
            
            Image {
                source: "kanra_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "kanra_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation { //delay animation so it occurs after
                        PauseAnimation { duration: 500 }//visible is true
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        
        Item {
            visible: root.stage >= 4
            height: 80
            
            Image {
                source: "bakyura_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "bakyura_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation { //delay animation so it occurs after
                        PauseAnimation { duration: 500 }//visible is true
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        
        Item {
            visible: root.stage >= 3
            height: 80
            
            Image {
                source: "tanaka_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "tanaka_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation { //delay animation so it occurs after
                        PauseAnimation { duration: 500 }//visible is true
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        
        Item {
            visible: root.stage >= 2
            height: 80
            
            Image {
                source: "setton_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "setton_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation { //delay animation so it occurs after
                        PauseAnimation { duration: 500 }//visible is true
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
        
        Item {
            id: first
            visible: false
            height: 80
            
            Image {
                source: "saika_icon.png"
                fillMode: Image.PreserveAspectFit
                height: parent.height
                width: parent.height
                anchors.left: parent.left
            }
            
            Image {
                source: "saika_message.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                
                height: parent.visible ? 80 : 0
                Behavior on height {
                    SequentialAnimation {
                        PauseAnimation { duration: 500 }
                        PropertyAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }
}
