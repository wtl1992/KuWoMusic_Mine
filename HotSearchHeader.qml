import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

Rectangle{
    id: rect
    width: window.width - leftAreaRectTagsLoader.width - 6
    height: 80
    x: leftAreaRectTagsLoader.width
    y: -10
    color: "#FFFFFF"

    property string minToolTip: qsTr("最小化")
    property string maxToolTip: qsTr("最大化")
    property string closeToolTip: qsTr("关闭")

    property bool maxWindowFlag: false

    Image{
        id: refreshImage
        source: "qrc:/images/resources/images/refresh.png"
        fillMode: Image.PreserveAspectFit
        width: 23
        x: 48
        y: (parent.height - refreshImage.height) / 2
    }

    Rectangle{
        id: textEditRect
        width: 240
        height: 30
        color: "#E8E8E8"
        radius: 14
        x: 78
        y: (parent.height - textEditRect.height) / 2
        TextEdit{
            id: textEdit
            width: parent.width - 10
            height: parent.height
            x: 10
            verticalAlignment: TextEdit.AlignVCenter
            horizontalAlignment: TextEdit.AlignLeft
            font.pixelSize: 18
        }

        Image{
            id: searchImage
            source: "qrc:/images/resources/images/search.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 18
            x: 210
            y: (parent.height - searchImage.height) / 2
        }

        Image{
            id: listenImage
            source: "qrc:/images/resources/images/listening.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 253
            y: (parent.height - listenImage.height) / 2
        }
    }

    Rectangle{
        id: topRightAreaRect
        width: 380
        height: parent.height
        x: parent.width - 390

        color: "#FFFFFF"

        Image{
            id: musicImage
            source: "qrc:/images/resources/images/music.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 20
            y: (parent.height - musicImage.height) / 2
        }

        Image{
            id: messageImage
            source: "qrc:/images/resources/images/message.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 66
            y: (parent.height - messageImage.height) / 2
        }

        Image{
            id: skinImage
            source: "qrc:/images/resources/images/skin.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 112
            y: (parent.height - skinImage.height) / 2
        }

        Image{
            id: fmImage
            source: "qrc:/images/resources/images/FM.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 158
            y: (parent.height - fmImage.height) / 2
        }

        Image{
            id: settingImage
            source: "qrc:/images/resources/images/setting.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 204
            y: (parent.height - settingImage.height) / 2
        }

        Image{
            id: lineImage
            source: "qrc:/images/resources/images/line.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 230
            y: (parent.height - lineImage.height) / 2
        }

        Image{
            id: minImage
            source: "qrc:/images/resources/images/min.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 260
            y: (parent.height - minImage.height) / 2
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                ToolTip.text: minToolTip
                onEntered: {
                    ToolTip.visible = true;
                }

                onExited: {
                    ToolTip.visible = false;
                }

                onClicked: {
                    window.showMinimized();
                }
            }
        }

        Image{
            id: maxImage
            source: "qrc:/images/resources/images/max.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 23
            x: 300
            y: (parent.height - maxImage.height) / 2
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                ToolTip.text: maxToolTip
                onEntered: {
                    ToolTip.visible = true;
                }

                onExited: {
                    ToolTip.visible = false;
                }

                onClicked: {
                    if (!maxWindowFlag){
                        window.showMaximized();
                        maxWindowFlag = true;
                    }
                    else{
                        window.showNormal();
                        maxWindowFlag = false;
                    }
                }
            }
        }

        Image{
            id: closeImage
            source: "qrc:/images/resources/images/close.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 20
            x: 346
            y: (parent.height - closeImage.height) / 2
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                ToolTip.text: closeToolTip
                onEntered: {
                    ToolTip.visible = true;
                }

                onExited: {
                    ToolTip.visible = false;
                }

                onClicked: {
                    window.close();
                }
            }
        }
    }
}
