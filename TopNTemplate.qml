import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle{
    id: item

    property var listModel
    property var gridViewBottom
    property var listViewRight

    width: 200
    height: 420
    color: "transparent"

    anchors.top: gridViewBottom
    anchors.left: listViewRight

    ListView{
        id: listView
        width: parent.width
        height: parent.height
        spacing: 5
        clip: true

        model: listModel
        delegate: Rectangle{
            id: listRect
            width: parent.width
            height: 80

            color: "transparent"

            clip: true

            Item{
                id: listItem
                width: parent.height
                height: parent.height
                anchors.left: listRect.left

                Image{
                    id: listImage
                    source: pic
                    sourceSize: Qt.size(parent.height, parent.height)
                    visible: false
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                }

                Rectangle {
                    id: listImageRect
                    color: "black"
                    anchors.fill: parent
                    radius: parent.width / 2
                    visible: false
                    antialiasing: true
                    smooth: true
                }
                OpacityMask {
                    id: listOpcityMask
                    anchors.fill: listImage
                    source: listImage
                    maskSource: listImageRect
                    visible: true
                    antialiasing: true
                }
            }

            Text{
                id: listText
                width: listView.width - listItem.width
                height: 20
                text: name
                anchors.left: listItem.right
                y: 10
                font.pixelSize: 18
                font.family: "微软雅黑"
                anchors.leftMargin: 5
            }

            Text{
                id: list2Text
                width: listView.width - listItem.width
                height: 20
                text: artist
                anchors.left: listItem.right
                y: 40
                font.pixelSize: 18
                font.family: "微软雅黑"
                color: "#CCCCCC"
                anchors.leftMargin: 5
            }

            PropertyAnimation{
                id: xForwardAnimation
                target: listRect
                property: "x"
                from: 0
                to: 20
                duration: 500
            }

            PropertyAnimation{
                id: xtoWardAnimation
                target: listRect
                property: "x"
                from: 20
                to: 0
                duration: 500
            }

            MouseArea{
                id: listMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    xForwardAnimation.start();
                }

                onExited: {
                    xtoWardAnimation.start();
                }
            }
        }
    }
}
