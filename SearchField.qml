import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    signal accepted(string value)

    color: "#1e1e1e"
    opacity: enabled ? 1 : 0.6
    border.color: searchInput.activeFocus ? Qt.lighter("#5F8575") : "transparent"
    border.width: 1


    TextInput {
        id: searchInput
        anchors.fill: parent
        color: "white"
        verticalAlignment: TextInput.AlignVCenter
        leftPadding: 30
        font.pixelSize: 14

        Image {
            anchors {
                left: parent.left
                leftMargin: 5
                verticalCenter: parent.verticalCenter
            }
            width: 16
            height: 16

            mipmap: true
            source: "assets/icons/search.png"
        }

        onAccepted: {
            root.accepted(text)
        }
    }
}
