/********************************************************************
This file was modified in 2017 by Qi Liang. The original lisence is
displayed below, as required.

Copyright (C) 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/

import QtQuick 2.5
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.sessions 2.0
import "../components"

Rectangle {
    id: root
    property bool viewVisible: false
    property bool debug: false
    property string notification
    property UserSelect userSelect: null
    property int interfaceVersion: org_kde_plasma_screenlocker_greeter_interfaceVersion ? org_kde_plasma_screenlocker_greeter_interfaceVersion : 0
    signal clearPassword()

	function login(){
		//make enter button 'clicked'
		enterButton.color = "#333";
		unclick.start();

		authenticator.tryUnlock(password.text);
	}
	Timer {
		id: unclick
		interval: 200
		onTriggered: enterButton.color= "#626262"
	}

    Connections {
        target: authenticator
        onFailed: {
            password.selectAll()
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        //visible: primaryScreen

		Image{
			anchors.top: parent.top
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.margins: 100
			id: dollars
			source: "dollars.png"
            width: 450
            height: 450

		}
		Column {
			id: mainColumn
			anchors.margins: 50
			width: 500
			anchors.top: dollars.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: 10

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

						height:30

						cursorVisible: false
						font.pixelSize: 20
						color: "black"
						font.family: "Ubuntu"
						selectionColor: "orange"
						echoMode: TextInput.Password
						clip: true

						id: password

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
