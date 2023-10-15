import QtQuick
import QtQuick.Window
import com.company.PlayerController

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

            infoProvider {
                songIndex: 0
                title: "asfsef"
                authorName: "asfsefefef sfef"
                imageSource: "assets/images/CruelSummer-TaylorSwift.png"
                audioSource: "qrc:/MusicPlayer/assets/audio/sample-15s.mp3"
            }

        }

        AudioInfoBox {
            id: secondSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }

            infoProvider {
                songIndex: 1
                title: "tttttt"
                authorName: "asfsefefef sfef"
                imageSource: "assets/images/FastCar-LukeCombs.png"
                audioSource: "qrc:/MusicPlayer/assets/audio/sample-12s.mp3"
            }
        }

        AudioInfoBox {
            id: thirdSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }

            infoProvider {
                songIndex: 2
                title: "aaaa aaaaaaaa"
                authorName: "asfsefefef sfef"
                imageSource: "assets/images/PaintTheTownRed-DojaCat.png"
                audioSource: "qrc:/MusicPlayer/assets/audio/sample-9s.mp3"
            }
        }

        AudioInfoBox {
            id: fourthSong
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 20
            }
            infoProvider {
                songIndex: 3
                title: "aaaa aaaaaaaa"
                authorName: "asfsefefef sfef"
                imageSource: "assets/images/Snooze-SZA.png"
                audioSource: "qrc:/MusicPlayer/assets/audio/sample-6s.mp3"
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

}
