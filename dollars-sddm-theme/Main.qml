import QtQuick 2.3
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0

Rectangle {
    Connections {
        target: sddm

        onLoginSucceeded: {
            //errorMessage.color = "steelblue"
            //errorMessage.text = textConstants.loginSucceeded
        }

        onLoginFailed: {
			password.selectAll()
        }
    }

	function login(){
		//make enter button 'clicked'
		enterButton.color = "#333";
		unclick.start();

		sddm.login(name.text, password.text, session.index)
	}
	Timer {
		id: unclick
		interval: 200
		onTriggered: enterButton.color= "#626262"
	}

    Rectangle {
        anchors.fill: parent
        color: "black"
        //visible: primaryScreen

        Rectangle {
			id: buttonsRow
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            z: 100
            width: 400

			visible: false

            border.color: "transparent"
            border.width: 0

            Row {
				spacing: 10

                ComboBox {
                    id: session
                    font.pixelSize: 14

                    model: sessionModel
                    index: sessionModel.lastIndex

                    opacity: 1
                    KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                }

                LayoutBox {
                    id: layoutBox
                    font.pixelSize: 14
                    opacity: 1

                    KeyNavigation.backtab: session; KeyNavigation.tab: layoutBox
                }

                Button {
                    id: shutdownButton
                    text: "SHUTDOWN"
                    width: 65
                    height: 25
					radius: 10

                    color: "#626262"
                    font.pixelSize: 10
                    font.bold: false

                    onClicked: sddm.powerOff()
                }

                Button {
                    id: rebootButton
                    text: "REBOOT"
                    width: 65
                    height: 25
					radius: 10

                    color: "#626262"
                    font.pixelSize: 10
                    font.bold: false

                    onClicked: sddm.reboot()
                }
            }
        }

		MouseArea{
			anchors.top: parent.top
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.margins: 100
			id: dollars
			width: image.width
			height: image.height

			onClicked: {
				nameRow.visible = !nameRow.visible
				buttonsRow.visible = !buttonsRow.visible
			}
			Image {
				id: image
				source: "dollars.png"
				width: 450
				height: 450
			}
		}
		Column {
			id: mainColumn
			anchors.margins: 50
			width: 500
			anchors.top: dollars.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: 10

			Row{
				id: nameRow
				spacing: 15
				anchors.horizontalCenter: parent.horizontalCenter
				visible: false

				Text{
					anchors.verticalCenter: parent.verticalCenter
					text:"USERNAME:"
					id:nameLabel
					color:"#f2f2f2"
					font.pixelSize: 16
					font.bold: true
					width: contentWidth
				}
				Rectangle {
					width: 220
					color: "white"
					radius: 30
					opacity: 1
					height: 30
					TextInput {
						id: name
						height: 30
						text: userModel.lastUser
						font.pixelSize: 25
						font.family: "Ubuntu"
						color: "black"

						anchors.right: parent.right
						anchors.left: parent.left
						anchors.verticalCenter: parent.verticalCenter
						anchors.leftMargin: 20;
						anchors.rightMargin: 20;
						Layout.fillWidth: true

						KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

						Keys.onPressed: {
							if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
								login()
								event.accepted = true
							}
						}
					}

				}
			}

			Row{
				spacing: 15
				anchors.horizontalCenter: parent.horizontalCenter
				Text{
					anchors.verticalCenter: parent.verticalCenter
					text:"PASSWORD:"
					id: pwLabel
					color:"#f2f2f2"
					font.pixelSize: 16
					font.bold: true
					width: contentWidth
				}
				Rectangle {
					width: 220
					color: "white"
					radius: 40
					opacity: 1
					height: 30
					TextInput {
						anchors.right: parent.right
						anchors.left: parent.left
						anchors.verticalCenter: parent.verticalCenter
						anchors.leftMargin: 20;
						anchors.rightMargin: 20;
						Layout.fillWidth: true

						height:30

						cursorVisible: false
						font.pixelSize: 20
						color: "black"
						font.family: "Ubuntu"
						selectionColor: "orange"
						echoMode: TextInput.Password
						clip: true

						id: password
						KeyNavigation.backtab: name; KeyNavigation.tab: session

						onCursorVisibleChanged: {
							if (cursorVisible)
							cursorVisible = false;
						}

						Keys.onPressed: {
							if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
								login()
								event.accepted = true
							}
						}

						focus: true
						//hack to make password field be focused when enter
						//see https://github.com/sddm/sddm/issues/501
						Timer {
							interval: 200
							running: true
							onTriggered: password.forceActiveFocus()
						}
					}
				}
			}
		}
		MouseArea{
			anchors.margins: parent.width/30
			anchors.top: mainColumn.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			width: 230

			onClicked: login()

			Rectangle{
				id: enterButton
				anchors.right: parent.right
				anchors.left: parent.left
				height: 35
				radius: 35
				color: "#626262"
				opacity: 1
				border.color: "#dadada"
				border.width: 3
				Text{
					text:"ENTER"
					color:"#f2f2f2"
					font.pixelSize: 16
					font.bold: true
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
				}
			}
		}
	}

	Component.onCompleted: {
		password.focus = true
	}
}
