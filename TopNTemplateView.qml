import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "qrc:/js/resources/javascript/Utils.js" as Utils
Rectangle{
    id: topNRect

    property string topNTextStr: qsTr("官方榜")
    property var topNModel
    property var topNRectNode
    property int rectHeight: 0

    Layout.preferredWidth: topNRectNode.width
    Layout.preferredHeight: rectHeight
    color: "transparent"

    Text{
        id: topNText

        width: 100
        height: 30

        font.pixelSize: 26
        font.family: "微软雅黑"

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors.top: topNRect.top
        anchors.left: topNRect.left
        anchors.topMargin: 10
        anchors.leftMargin: 10

        text: topNTextStr
    }

    GridView{
        id: topNGridView

        width: topNRectNode.width

        height: Math.ceil(topNGridView.count  * 1.0 / Math.floor(topNGridView.width * 1.0 / topNGridView.cellWidth * 1.0)) * topNGridView.cellHeight
        cellWidth: 210
        cellHeight: 210

        anchors.top: topNText.bottom
        anchors.left: topNText.left

        anchors.topMargin: 10
        anchors.leftMargin: 10

        model: topNModel

        delegate: Rectangle{
            id: itemRect
            width: topNGridView.cellWidth - 10
            height: topNGridView.cellHeight - 10

            color: "transparent"

            x: 5
            y: 5
            clip: true

            Image {
                id: image
                smooth: true
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                visible: false
                source: pic

                antialiasing: true
            }
            Rectangle {
                id: rect
                color: "#CCCCCC"
                anchors.fill: parent
                radius: 12
                visible: false
                antialiasing: true
                smooth: true
            }
            OpacityMask {
                id: opcityMask
                anchors.fill: image
                source: image
                maskSource: rect
                visible: true
                antialiasing: true
            }

            Text{
                id: guanFangText
                width: 100
                height: 30

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: topNTag
                font.pixelSize: 28
                font.family: "微软雅黑"
                color: "#FFFFFF"

                anchors.centerIn: parent
            }

            ScaleAnimator{
                id: scaleBigAnimator
                target: opcityMask
                from: 1
                to: 1.2
                duration: 800
            }

            ScaleAnimator{
                id: scaleSmallAnimator
                target: opcityMask
                from: 1.2
                to: 1
                duration: 800
            }

            MouseArea{
                id: mouseArea
                hoverEnabled: true

                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onEntered: {
                    scaleBigAnimator.start();
                }
                onExited: {
                   scaleSmallAnimator.start();
                }

                onClicked: {
                    topNRealPageLoader.item.id = id;
                    topNRealPageLoader.item.realTextStr = topNTag;
                    Utils.setAllLoadersUnVisible();
                    topNRealPageLoader.visible = true;
                    leftAreaRectTagsLoader.item.topNDetail = uuidUtil.getUUID();
                }
            }
        }

        onCountChanged: {
            rectHeight = topNText.height + Math.ceil(topNGridView.count  * 1.0 / Math.floor(topNGridView.width * 1.0 / topNGridView.cellWidth * 1.0)) * topNGridView.cellHeight;
        }
    }
}
