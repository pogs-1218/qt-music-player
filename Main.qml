import QtQuick
import QtQuick.Window
import com.company.PlayerController

Window {
    id: root
    width: 640
    height: 640
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

        ImageButton{
            id: playlistButton
            anchors{
                top: parent.top
                right: parent.right
                topMargin: 10
                rightMargin: 10
            }
            width: 30
            height: 30
            source:"assets/icons/list-music.png"
            onClicked: {
                playlistPanel.hidden = !playlistPanel.hidden
            }
        }
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
            id: songInfo

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
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
            enabled: !!PlayerController.currentSong
            opacity: enabled? 1 : 0.3

            ImageButton {
                id: previousButton
                width: 60; height: 60;
                source: "assets/icons/backward-fast.png"
                onClicked: PlayerController.switchToPreviousSong()
            }

            ImageButton {
                id: playPauseButton
                width: 60; height: 60;
                source: PlayerController.playing ? "assets/icons/stop.png" : "assets/icons/play.png"
                onClicked: PlayerController.playPause()
            }

            ImageButton {
                id: nextButton
                width: 60; height: 60;
                source: "assets/icons/forward-fast.png"
                onClicked: PlayerController.switchToNextSong()
            }
        }
    }

    PlayListPanel {
        id: playlistPanel
        anchors.top: topbar.bottom
        x: hidden ? parent.width : parent.width - width
    }

}
