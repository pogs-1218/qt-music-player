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
            imageSource: "assets/images/CruelSummer-TaylorSwift.png"
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
            imageSource: "assets/images/FastCar-LukeCombs.png"
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
            imageSource: "assets/images/PaintTheTownRed-DojaCat.png"
        }

        AudioInfoBox {
            id: fourthSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
            songIndex: 3
            title: "aaaa aaaaaaaa"
            authorName: "asfsefefef sfef"
            imageSource: "assets/images/Snooze-SZA.png"
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

            ImageButton {
                id: previousButton
                width: 60; height: 60;
                source: "assets/icons/backward-fast.png"
                onClicked: playerController.switchToPreviousSong()
            }

            ImageButton {
                id: playPauseButton
                width: 60; height: 60;
                source: playerController.playing ? "assets/icons/stop.png" : "assets/icons/play.png"
                onClicked: playerController.playPause()
            }

            ImageButton {
                id: nextButton
                width: 60; height: 60;
                source: "assets/icons/forward-fast.png"
                onClicked: playerController.switchToNextSong()
            }
        }
    }

    QtObject {
        id: playerController

        property int currentSongIndex: 0
        property int songCount: 4
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
