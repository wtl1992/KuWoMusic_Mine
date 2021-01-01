import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer

Rectangle{
    id: rect

    width: window.width
    height: 60

    color: "black"

    property string musicSongTextStr: qsTr("歌曲")
    property string musicSongSingerTextStr: qsTr("歌手")
    property string musicSongLineTextStr: qsTr("/")
    property string progressTimeSpanTextStr: qsTr("00:00")
    property string progressTimeTotalTextStr: qsTr("00:00")
    property string templateSource: "qrc:/images/resources/images/bottomPlayArea/template.jpg"
    property int progressingBarRectWidth: 0
    property alias playLengthRectWidth: playLengthRect.width

    signal startPlayFlag
    signal stopPlayFlag

    property bool playFlag: false


    FileDialog{
        id: fileDialog
        title: "选择目录"
        selectExisting: true
        selectFolder: true
        selectMultiple: false
        onAccepted: {
            let musicUrl = topNRealPageLoader.item.downloadMusicUrl;
            let folder = fileDialog.fileUrl;
            let musicName = topNRealPageLoader.item.downloadMusicName;

            if (musicUrl !== ""){
                mediaPlayer.download(musicUrl,folder,musicName);
            }
        }

        onRejected: {

        }
    }

    Row{
        id: row

        Rectangle{
            id: previousRect
            width: rect.height - 8
            height: rect.height

            color: "transparent"

            Image{
                id: previousButton
                source: "qrc:/images/resources/images/bottomPlayArea/previous.png"
                height: 40
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle{
            id: playRect
            width: rect.height - 8
            height: rect.height

            color: "transparent"

            Image{
                id: playButton
                source: "qrc:/images/resources/images/bottomPlayArea/play.png"
                height: 40
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }
            MouseArea{
                id: playMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    playRect.opacity = 0.6;
                }

                onExited: {
                    playRect.opacity = 1.0;
                }

                onClicked: {
                    if (playFlag){
                        mediaPlayer.pause();
                        playButton.source = "qrc:/images/resources/images/bottomPlayArea/play.png";
                        playFlag = false;
                    }
                    else{
                        mediaPlayer.play();
                        playButton.source = "qrc:/images/resources/images/bottomPlayArea/playing.png";
                        playFlag = true;
                    }
                }
            }
        }

        Rectangle{
            id: nextRect
            width: rect.height - 8
            height: rect.height

            color: "transparent"

            Image{
                id: nextButton
                source: "qrc:/images/resources/images/bottomPlayArea/next.png"
                height: 40
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle{
            id: musicPicRect
            width: rect.height
            height: rect.height

            color: "transparent"

            Image{
                id: musicPicImage
                source: templateSource
                height: rect.height
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                smooth: true
                sourceSize: Qt.size(rect.height,rect.height)
            }
        }

        Rectangle{
            id: playLengthRect
            width: rect.width - 500
            height: rect.height

            color: "transparent"

            Rectangle{
                id: progressBarRect
                width: parent.width - 10
                height: 3

                x: 5

                color: "#FFFFFF"

                anchors.bottom: playLengthRect.bottom
                anchors.bottomMargin: 15

                MouseArea{
                    id: progressMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onMouseXChanged: {
                        ToolTip.text = Timer.timeToMinute((mouseX * 1.0 / progressBarRect.width * 1.0) * mediaPlayer.duration);
                    }

                    onEntered: {
                        ToolTip.visible = true;
                    }

                    onExited: {
                        ToolTip.visible = false;
                    }

                    onClicked: {
                        mediaPlayer.setPos((mouseX * 1.0 / progressBarRect.width * 1.0) * mediaPlayer.duration);
                    }
                }
            }

            Rectangle{
                id: progressingBarRect
                width: progressingBarRectWidth
                height: 3

                x: 5

                color: "#1E90FF"

                anchors.bottom: playLengthRect.bottom
                anchors.bottomMargin: 15

            }

            Text {
                id: musicSongText
                text: musicSongTextStr
                height: 30
                font.pixelSize: 18
                font.family: "微软雅黑"
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }


            Text {
                id: musicLineText
                text: musicSongLineTextStr
                width: 30
                height: 30
                font.pixelSize: 18
                font.family: "微软雅黑"
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.left: musicSongText.right
            }

            Text {
                id: musicSongSingerText
                text: musicSongSingerTextStr
                height: 30
                font.pixelSize: 18
                font.family: "微软雅黑"
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.left: musicLineText.right
            }

            Rectangle{
                id: timeSpanRect

                width: 180
                height: 30

                color: "transparent"

                anchors.right: playLengthRect.right

                Text {
                    id: progressTimeSpanText
                    text: progressTimeSpanTextStr
                    width: 60
                    height: 30
                    font.pixelSize: 18
                    font.family: "微软雅黑"
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Text{
                    id: progressLineText
                    text: musicSongLineTextStr
                    width: 30
                    height: 30
                    font.pixelSize: 18
                    font.family: "微软雅黑"
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: progressTimeSpanText.right
                }

                Text {
                    id: progressTimeTotalText
                    text: progressTimeTotalTextStr
                    width: 60
                    height: 30
                    font.pixelSize: 18
                    font.family: "微软雅黑"
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: progressLineText.right
                }
            }
        }


        Rectangle{
            id: zujianRect
            width: 300
            height: rect.height

            color: "transparent"

            Row{
                id: zujianRow

                Rectangle{
                    id: emptyRect
                    width: 70
                    height: zujianRect.height
                    color: "transparent"
                }

                Rectangle{
                    id: volumnRect
                    width: zujianRect.height
                    height: zujianRect.height
                    color: "transparent"

                    Image{
                        id: volumnImage
                        height: 26
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/resources/images/bottomPlayArea/volumn.png"
                        sourceSize: Qt.size(volumnRect.width,volumnRect.height)
                        anchors.centerIn: parent
                    }
                }

                Rectangle{
                    id: likeRect
                    width: zujianRect.height
                    height: zujianRect.height
                    color: "transparent"

                    Image{
                        id: likeImage
                        height: 26
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/resources/images/bottomPlayArea/like.png"
                        sourceSize: Qt.size(likeRect.width,likeRect.height)
                        anchors.centerIn: parent
                    }
                }

                Rectangle{
                    id: downloadRect
                    width: zujianRect.height
                    height: zujianRect.height
                    color: "transparent"

                    Image{
                        id: downloadImage
                        height: 26
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/resources/images/bottomPlayArea/download.png"
                        sourceSize: Qt.size(downloadRect.width,downloadRect.height)
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        id: downloadMouseArea
                        anchors.fill: parent

                        onClicked: {
                            fileDialog.open();
                        }
                    }
                }
            }
        }
    }

    onStartPlayFlag: {
        mediaPlayer.play();
        playButton.source = "qrc:/images/resources/images/bottomPlayArea/playing.png";

        console.log(playButton.source)
        playFlag = true;
    }
}
