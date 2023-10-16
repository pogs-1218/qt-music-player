import QtQuick
import com.company.PlayerController
import com.company.AudioSearchModel

Rectangle {
    id: root
    color: "#333333"

    property bool hidden: true

    ListView {
        id: listView
        model: AudioSearchModel

        anchors {
            fill: parent
            margins: 20
        }
        spacing: 10
        clip: true

        visible: !AudioSearchModel.isSearching

        delegate : Rectangle {
            id: delegate

            required property string audioName
            required property string audioAuthor
            required property url audioSource
            required property url audioImageSource
            required property int index

            width: listView.width
            height: 50

            color: "#1e1e1e"

            Image {
                id: audioImage
                width:32
                height:32
                anchors {
                    left: parent.left
                    leftMargin: 5
                    verticalCenter: parent.verticalCenter
                }
                source: delegate.audioImageSource
            }

            Column {
                anchors {
                    top: parent.top
                    left: audioImage.right
                    right: parent.right
                    margins:5
                }
                spacing:5

                Text{
                    width: parent.width

                    elide: Text.ElideRight
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 12

                    color: "white"
                    text: delegate.audioName

                    font {
                        pixelSize: 16
                        bold: true
                    }
                }

                Text {
                    width: parent.width
                    elide: Text.ElideRight
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 8

                    color: "gray"
                    text: delegate.audioAuthor

                    font {
                        pixelSize: 12
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.hidden = true
                    PlayerController.addAudio(delegate.audioName,
                                              delegate.audioAuthor,
                                              delegate.audioSource,
                                              delegate.audioImageSource)
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent
        color: "gray"
        font.pixelSize: 30
        visible: AudioSearchModel.isSearching || listView.count === 0
        text: if (AudioSearchModel.isSearching) {
                  return "Searching..."
              } else if (listView.count === 0) {
                  return "No result"
              }
    }

    Behavior on y {
        PropertyAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
