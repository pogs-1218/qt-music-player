import QtQuick
import QtQuick.Window

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Music Player")

    Rectangle {
        id: topbar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 50
        color: "#5F8575"
    }

    Rectangle {
        id: mainSection
        anchors {
            top: topbar.bottom
            bottom: bottomBar.top
            left: parent.left
            right: parent.right
        }
        color: "#1e1e1e"

        AudioInfoBox {
            id: firstSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
            songIndex: 0
            title: "asfsef"
            authorName: "asfsefefef sfef"
            imageColor: "red"
        }

        AudioInfoBox {
            id: secondSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
            songIndex: 1
            title: "tttttt"
            authorName: "asfsefefef sfef"
            imageColor: "yellow"
        }

        AudioInfoBox {
            id: thirdSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
            songIndex: 2
            title: "aaaa aaaaaaaa"
            authorName: "asfsefefef sfef"
            imageColor: "pink"
        }
    }

    Rectangle {
        id: bottomBar
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 100
        color: "#333333"

        Row {
            anchors.centerIn: parent
            spacing: 20

            TextButton {
                id: previousButton
                width: 50; height: 50;
                text: "<"
                onClicked: playerController.switchToPreviousSong()
            }

            TextButton {
                id: playPauseButton
                width: 50; height: 50;
                text: playerController.playing ? "Play" : "Pause"
                onClicked: playerController.playPause()
            }

            TextButton {
                id: nextButton
                width: 50; height: 50;
                text: ">"
                onClicked: playerController.switchToNextSong()
            }
        }
    }

    QtObject {
        id: playerController

        property int currentSongIndex: 0
        property int songCount: 3
        property bool playing: false

        function playPause() {
            playing =  !playing
        }

        function switchToPreviousSong() {
            if (currentSongIndex > 0) {
                currentSongIndex--
            } else {
                currentSongIndex = songCount - 1
            }
        }

        function switchToNextSong() {
            if (currentSongIndex + 1 >= songCount) {
                currentSongIndex = 0
            } else {
                currentSongIndex++
            }
        }
    }

}
