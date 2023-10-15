import QtQuick
import com.company.PlayerController
import MusicPlayer

Item {
    id: root

    visible: !!PlayerController.currentSong

    Image {
        id: albumImage

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width: 150
        height: 150

        source: PlayerController.currentSong.imageSource
    }

    Text {
        id: titleText

        anchors {
            bottom: parent.verticalCenter
            left: albumImage.right
            right: parent.right
            margins: 20
        }

        color: "white"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: PlayerController.currentSong.title

        font {
            pixelSize: 20
            bold: true
        }
    }

    Text {
        id: authorText

        anchors {
            top: parent.verticalCenter
            left: titleText.left
            right: parent.right
            topMargin: 5
        }

        color: "gray"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: PlayerController.currentSong.authorName

        font {
            pixelSize: 16
        }
    }

    onVisibleChanged: {
        if (visible) {
            PlayerController.changeAudioSource(PlayerController.currentSong.audioSource)
        } else {

        }
    }
}
