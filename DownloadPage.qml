import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import "qrc:/js/resources/javascript/Ajax.js" as Ajax

Rectangle{
    id: downloadRect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3

    property string downloadTextStr: qsTr("下载管理")
    property string downloadedTextStr: qsTr("已下载")
    property string downloadingTextStr: qsTr("下载中")
    property string dirTextStr: qsTr("下载目录")
    property string downloadSettingTextStr: qsTr("下载设置")
    property string batchSelectAllTextStr: qsTr("批量操作")
    property string exportTextStr: qsTr("导出")
    property string singingTextStr: qsTr("传歌")
    property string loadingTextStr: "数据加载中......"
    property string playButtonStr: "播放"

    color: "transparent"

    AnimatedImage{
        id: loadingImage
        source: "qrc:/images/resources/images/moviePage/loading.gif"
        anchors.centerIn: parent
    }

    ListModel{
        id: musicslistModel
    }

    ScrollView{
        id: downloadScrollView

        width: parent.width
        height: parent.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        ColumnLayout{
            id: downloadColumnLayout

            width: parent.width
            height: parent.height

            Rectangle{
                id: downloadTagTextRect
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 30

                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                color: "transparent"

                Text{
                    id: downloadTagText
                    text: downloadTextStr
                    font.pixelSize: 20
                    color: "#555555"
                    anchors.verticalCenter: downloadTagTextRect.verticalCenter
                    anchors.left: downloadTagTextRect.left
                    anchors.leftMargin: 20
                }
            }

            Rectangle{
                id: downloadTagRect

                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 40
                color: "transparent"

                Text {
                    id: downloadedText
                    text: downloadedTextStr
                    font.pixelSize: 26
                    font.family: "微软雅黑"
                    width: 100
                    height: 30
                    x: 30
                }

                Rectangle{
                    id: lineBottonRect
                    width: downloadedText.width -20
                    height: 4
                    color: "#ffe443"
                    anchors.bottom: downloadTagRect.bottom
                    x: 30
                }

                Text {
                    id: downloadingText
                    text: downloadingTextStr
                    font.pixelSize: 26
                    font.family: "微软雅黑"
                    width: 100
                    height: 30
                    color: "#555555"
                    x: 130
                }

                Rectangle{
                    id: rightDownloadRect
                    width: 300
                    height: 40

                    color: "transparent"
                    anchors.right: downloadTagRect.right
                    anchors.top: downloadTagRect.top

                    SmallRect{
                        id: downloadSmallRect
                        sourceImageStr: "qrc:/images/resources/images/downloadPage/dir.png"
                        textStr: dirTextStr
                        rightDownloadRect: rightDownloadRect
                        anchorsLeft: rightDownloadRect.left
                        anchorsLeftMargin: 0
                    }

                    SmallRect{
                        id: downloadSettingSmallRect
                        sourceImageStr: "qrc:/images/resources/images/setting.png"
                        textStr: downloadSettingTextStr
                        rightDownloadRect: rightDownloadRect
                        anchorsLeft: downloadSmallRect.right
                        anchorsLeftMargin: 10
                    }
                }
            }

            Rectangle{
                id: playRect
                width: parent.width
                height: 40
                color: "transparent"


                SmallRect{
                    id: playAllSmallRect
                    sourceImageStr: "qrc:/images/resources/images/downloadPage/play.png"
                    textStr: downloadSettingTextStr
                    rightDownloadRect: playRect
                    anchorsLeft: playRect.left
                    anchorsLeftMargin: 10
                    rectColorStr: "#88ffe443"
                    isButtonShow: true
                }

                SmallRect{
                    id: batchSelectAllSmallRect
                    sourceImageStr: "qrc:/images/resources/images/downloadPage/batch.png"
                    textStr: batchSelectAllTextStr
                    rightDownloadRect: playRect
                    anchorsLeft: playAllSmallRect.right
                    anchorsLeftMargin: 10
                    rectColorStr: "#88ffe443"
                    isButtonShow: true
                }


                Rectangle{
                    id: rightPlayRect
                    width: 300
                    height: playRect.height

                    anchors.right: playRect.right

                    color: "transparent"

                    SmallRect{
                        id: exportSmallRect
                        sourceImageStr: "qrc:/images/resources/images/downloadPage/export.png"
                        textStr: exportTextStr
                        rightDownloadRect: rightPlayRect
                        anchorsLeft: rightPlayRect.left
                        anchorsLeftMargin: 5
                    }

                    SmallRect{
                        id: singingSmallRect
                        sourceImageStr: "qrc:/images/resources/images/downloadPage/refresh.png"
                        textStr: singingTextStr
                        rightDownloadRect: rightPlayRect
                        anchorsLeft: exportSmallRect.right
                        anchorsLeftMargin: 10
                    }
                }


            }

            ListView{
                id: listView
                model: musicslistModel

                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 82 * listView.count
                delegate: Rectangle{
                    id: musicRect

                    width: parent.width
                    height: 80

                    border.width: 1
                    border.color: "#000000"

                    color: "transparent"

                    Text{
                        id: musicPicText
                        text: index
                        width: parent.height
                        height: parent.height

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: musicRect.left
                        font.pixelSize: 20
                        font.family: "微软雅黑"
                        color: "#333"
                        anchors.leftMargin: 5
                    }

                    Image{
                        id: musicPicImage
                        source: pic
                        smooth: true
                        width: musicRect.height
                        fillMode: Image.PreserveAspectFit
                        anchors.left: musicPicText.right
                        anchors.leftMargin: 5
                    }

                    Rectangle{
                        id: musicNameSmallRect
                        width: 260
                        height: musicRect.height
                        color: "transparent"
                        x: musicPicImage.width + 5
                        anchors.left: musicPicImage.right
                        anchors.leftMargin: 5

                        Text{
                            id: nameText
                            text: name
                            font.pixelSize: 20
                            font.family: "微软雅黑"
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle{
                        id: musicArtistSmallRect
                        width: 200
                        height: musicRect.height
                        color: "transparent"
                        x: musicNameSmallRect.width + 5
                        anchors.left: musicNameSmallRect.right
                        anchors.leftMargin: 5

                        Text{
                            id: artistText
                            text: artist
                            font.pixelSize: 20
                            font.family: "微软雅黑"
                            anchors.centerIn: parent
                        }
                    }


                    Rectangle{
                        id: musicDureationSmallRect
                        width: 200
                        height: musicRect.height
                        color: "transparent"
                        x: musicArtistSmallRect.width + 5
                        anchors.left: musicArtistSmallRect.right
                        anchors.leftMargin: 5

                        Text{
                            id: durationText
                            text: songTimeMinutes
                            font.pixelSize: 20
                            font.family: "微软雅黑"
                            anchors.centerIn: parent
                        }
                    }


                    Rectangle{
                        id: musicPlayButtonSmallRect
                        width: 100
                        height: musicRect.height
                        color: "transparent"
                        x: musicDureationSmallRect.width + 5
                        anchors.left: musicDureationSmallRect.right
                        anchors.leftMargin: 5

                        Text{
                            id: playButtonText
                            text: playButtonStr
                            font.pixelSize: 20
                            anchors.centerIn: parent
                        }
                    }

                }
            }
        }
    }

    Rectangle{
        id: loadingRect
        width: parent.width
        height: 30
        color: "transparent"
        anchors.bottom: downloadRect.bottom

        Text{
            id: loadingText
            width: 300
            height: parent.height
            font.bold: true
            font.family: "微软雅黑"
            font.pixelSize: 20
            anchors.centerIn: parent
            text: loadingTextStr
        }
    }

    Component.onCompleted: {
        //获取音乐歌单
        Ajax.get("https://ljxwtl.cn/kuwo/playListInfo/3114865833/1/30",function(response,data){

            let musicsList = data.data.musicList;

            console.log(data.data.musicList.length)
            console.log(musicsList.length)
            for (let i=0;i<musicsList.length;i++){
                musicsList[i].index = i+1;
                musicslistModel.append(musicsList[i]);
            }

            loadingImage.visible = false;
            loadingText.visible = false;
        },function(){});

    }
}

