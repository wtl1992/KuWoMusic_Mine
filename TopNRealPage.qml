import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer

Rectangle{
    id: rect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3

    property int id
    property string realTextStr: qsTr("酷我飙升榜")
    property int pageIndex: 1
    property bool flag: true
    property string loadingTextStr: "数据加载中......"
    property bool startFlag: false
    property string downloadMusicUrl
    property string downloadMusicName

    function setAllLoadersUnVisible(){
        for (let i=0;i< loaders.length;i++){
            loaders[i].visible = false;
        }
    }

    function setAllMusicReset(){
        for (let i=0;i<listView.count;i++){
            listView.itemAtIndex(i).color = "transparent";
            listView.itemAtIndex(i).musicPlayImageSource = "qrc:/images/resources/images/topN/play.png";
        }
    }

    function setMusicButtonAction(innerRect){
        //设置播放按钮的动作
        setAllMusicReset();
        innerRect.color = "#CCCCCC";
        innerRect.musicPlayImageSource = "qrc:/images/resources/images/topN/playing.png";
    }

    color: "transparent"

    ListModel{
        id: listModel
    }

    AnimatedImage{
        id: loadingImage
        source: "qrc:/images/resources/images/moviePage/loading.gif"
        anchors.centerIn: parent
    }

    ScrollView{
        id: scrollView

        anchors.fill: rect

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn


        //Component.onCompleted: ScrollBar.vertical.position = 1.0
        ScrollBar.vertical.onPositionChanged: {
            let scrollBarSize = ScrollBar.vertical.size * 1000;
            let scrollBarHeight = ScrollBar.vertical.height;
            let scrollBarPosition = ScrollBar.vertical.position;
            //            console.log(scrollBarHeight * scrollBarPosition + scrollBarSize);
            //            console.log(scrollView.height);
            //            console.log(flag);
            if (scrollBarHeight * scrollBarPosition + scrollBarSize > scrollView.height * 0.9 && flag){
                flag = false;
                pageIndex ++;
                loadingText.visible = true;
                Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/"+id+"/" +pageIndex+ "/30",
                         function(result, data){
                             loadingText.visible = false;
                             let dataList = data.data.musicList;
                             for (let i=0;i<dataList.length;i++){
                                 listModel.append(dataList[i]);
                             }

                             Timer.setTimeout(function(){
                                 flag = true;
                             },1000);
                         },function(){

                         });
            }
        }


        ColumnLayout{
            id: columnLayout

            x: 5
            Text{
                id: realText
                text: realTextStr
                font.family: "微软雅黑"
                font.pixelSize: 20
            }

            ListView{
                id: listView
                Layout.preferredWidth: scrollView.width
                Layout.preferredHeight: 100 * listView.count

                model: listModel

                delegate: Rectangle{
                    id: innerRect

                    property alias musicPlayImageSource: musicPlayImage.source

                    width: listView.width
                    height: 100

                    color: "transparent"

                    border.width: 1
                    border.color: "#000000"

                    Text{
                        id: indexText
                        text: index + 1
                        width: 30
                        height: parent.height
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                        color: "#000000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Rectangle{
                        id: musicRect
                        width: innerRect.height
                        height: innerRect.height -2
                        y: 1

                        color: "transparent"

                        Image{
                            id: musicImage
                            source: pic
                            height: 80
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(musicImage.height,musicImage.height)
                            anchors.centerIn: parent
                        }
                        anchors.left: indexText.right
                    }

                    Text{
                        id: musicText
                        text: name
                        width: 200
                        height: innerRect.height
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        clip: true
                        anchors.left: musicRect.right
                    }

                    Text{
                        id: musicAlbumText
                        text: album
                        width: 180
                        height: innerRect.height
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        clip: true
                        anchors.left: musicText.right
                    }

                    Text{
                        id: musicArtistText
                        text: artist
                        width: 180
                        height: innerRect.height
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        clip: true
                        anchors.left: musicAlbumText.right
                    }

                    Text{
                        id: musicSongTimeMinutesText
                        text: songTimeMinutes
                        width: 180
                        height: innerRect.height
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        clip: true
                        anchors.left: musicArtistText.right
                    }


                    Rectangle{
                        id: musicPlayRect
                        width: innerRect.height
                        height: innerRect.height - 2
                        y: 1

                        color: "transparent"

                        anchors.left: musicSongTimeMinutesText.right

                        Image{
                            id: musicPlayImage
                            source: "qrc:/images/resources/images/topN/play.png"
                            height: 80
                            fillMode: Image.PreserveAspectFit
                            anchors.centerIn: parent

                            MouseArea{
                                id: mouseArea
                                anchors.fill: parent
                                onClicked: {
                                    //setAllLoadersUnVisible();
                                    Ajax.get("https://ljxwtl.cn/kuwo/songInfo/" + rid,function(result,data){
                                        let url = data.url;
                                        mediaPlayer.setUrl(url);

                                       //设置全局下载的url，以便用于下载使用
                                        downloadMusicUrl = url;
                                        downloadMusicName = name + "-" + artist + ".mp3";

                                        let node = bottomPlayControlLoader.item;
                                        node.musicSongTextStr = name;
                                        node.musicSongSingerTextStr = artist;
                                        node.templateSource = pic;
                                        node.startPlayFlag();

                                        startFlag = true;

                                        setMusicButtonAction(innerRect);

                                        //console.log(mouseAreaClick)
                                    },function(){});
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    onIdChanged: {
        if (id !== undefined){
            listModel.clear();
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/"+id+"/1/30",function(result,data){
                let dataList = data.data.musicList;
                for (let i=0;i<dataList.length;i++){
                    listModel.append(dataList[i]);
                }

                loadingImage.visible = false;
                loadingText.visible = false;
            },function(){});
        }
    }

    Rectangle{
        id: loadingRect
        width: parent.width
        height: 30
        color: "transparent"
        anchors.bottom: rect.bottom

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
}
