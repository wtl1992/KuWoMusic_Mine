import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer
import "qrc:/js/resources/javascript/Utils.js" as Utils

Rectangle{
    id: musicDetailRect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3
    color: "transparent"

    property string headerImageSource: qsTr("http://p3.music.126.net/56EXLMyRACeXdQrnGvESmg==/109951165587197682.jpg?param=200y200")
    property string headerSongMusicTextStr: qsTr("告别2020")
    property string headerSongMusicLineTextStr: qsTr(" | ")
    property string headerAuthorTextStr: qsTr("鮭魚先森")

    property string headerMusicCoverSourceImageStr: qsTr("http://p4.music.126.net/hze1LVYSNEr4L8CztRlINQ==/109951165448060945.jpg")
    property string updateTimeStr: dateTimeUtil.parseTimeStamp(1609289300952)

    property string musicId: "24381616"
    property var bigData

    property int currentIndex: 0
    property int pageIndex: 0
    property int pageNumber: 30
    property bool flag: true
    property string loadingTextStr: "数据加载中......"

    function clearAllSettings(){
        for (let i=0;i<listModel.count;i++){
            let view = listView.itemAtIndex(i);
            view.playButtonImageSource = "qrc:/images/resources/images/topN/play.png";
            view.color = "transparent";
        }
    }

    function commonCodeDealDetailPage(){
        listModel.clear();

        Ajax.get("http://musicapi.leanapp.cn/playlist/detail?id=" + musicId,function(response,data){
            bigData = data.playlist;

            headerImageSource = bigData.creator.backgroundUrl;
            headerSongMusicTextStr = bigData.name;
            headerAuthorTextStr = bigData.creator.nickname;
            headerMusicCoverSourceImageStr = bigData.coverImgUrl;
            updateTimeStr = dateTimeUtil.parseTimeStamp(bigData.updateTime);
            loadingImage.visible = false;

            let trackIds = bigData.trackIds;

            for (let i=0;i<30;i++){
                Ajax.get("http://musicapi.leanapp.cn/song/detail?ids=" + trackIds[i].id,function(response,data){
                    let song = data.songs[0];
                    listModel.append(song);
                },function(){});
            }


        },function(){});
    }

    AnimatedImage{
        id: loadingImage
        source: "qrc:/images/resources/images/moviePage/loading.gif"
        anchors.centerIn: parent
        cache: true
    }

    ListModel{
        id: listModel
    }

    ScrollView{
        id: scrollView
        width: parent.width
        height: parent.height

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

                let trackIds = bigData.trackIds;

                for (let i=pageIndex * pageNumber;i<pageIndex * pageNumber + pageNumber;i++){
                    loadingText.visible = true;
                    Ajax.get("http://musicapi.leanapp.cn/song/detail?ids=" + trackIds[i].id,function(response,data){
                        let song = data.songs[0];
                        listModel.append(song);

                        console.log("-----------------------------------------------------" + trackIds[i].id)
                        loadingText.visible = false;
                    },function(){});
                    Timer.setTimeout(function(){
                        flag = true;
                    },1000);
                }
            }
        }

        ColumnLayout{
            id: columnLayout

            Rectangle{
                id: musicDetailHeaderRect
                Layout.preferredWidth: scrollView.width
                Layout.preferredHeight: 200

                color: "transparent"

                Row{
                    id: row
                    width: 572
                    height: 200

                    anchors.centerIn: musicDetailHeaderRect

                    RadiusImage {
                        id: headerImage
                        imageWidth: 200
                        imageHeight: 200
                        anchorsTop: row.top
                        anchorsLeft: row.left
                        leftMargin: 0
                        topMargin: 0
                        imageSource: headerImageSource
                        imageRasdius: 100
                    }

                    RotationAnimation{
                        id: headerAnimation
                        target: headerImage
                        from: 0
                        to: 360
                        direction: RotationAnimation.Clockwise
                        duration: 2000
                        loops: Animation.Infinite
                        running: true
                    }

                    Rectangle{
                        id: innerRect

                        width: 360
                        height: 200
                        color: "transparent"

                        anchors.left: headerImage.right
                        anchors.leftMargin: 10

                        Rectangle{
                            width: parent.width
                            height: 100
                            anchors.centerIn: parent

                            color: "transparent"

                            Text{
                                id: headerImageText
                                text: headerSongMusicTextStr + headerSongMusicLineTextStr
                                font.family: "微软雅黑"
                                font.pixelSize: 20
                                anchors.left: headerImage.right
                                anchors.leftMargin: 10
                            }

                            Image{
                                id: headerMusicCoverImage
                                source: headerMusicCoverSourceImageStr
                                width: 60
                                height: 60
                                smooth: true
                                sourceSize: Qt.size(headerMusicCoverImage.width,headerMusicCoverImage.height)

                                fillMode: Image.PreserveAspectFit
                                anchors.left: headerImageText.left
                                anchors.top: headerImageText.bottom
                                anchors.topMargin: 10
                            }

                            Text {
                                id: headerAuthorText
                                text: headerAuthorTextStr
                                font.family: "微软雅黑"
                                font.pixelSize: 20

                                anchors.left: headerMusicCoverImage.right
                                anchors.leftMargin: 10
                                anchors.top: headerMusicCoverImage.top
                                anchors.topMargin: 10
                            }

                            Text {
                                id: headerUpdateText
                                text: updateTimeStr + qsTr("更新")
                                font.family: "微软雅黑"
                                font.pixelSize: 16

                                anchors.left: headerAuthorText.right
                                anchors.leftMargin: 10
                                anchors.top: headerMusicCoverImage.top
                                anchors.topMargin: 10
                                color: "#CCCCCC"
                            }
                        }
                    }
                }
            }


            ListView{
                id: listView

                Layout.preferredWidth: scrollView.width
                Layout.preferredHeight: 100 * listView.count

                model: listModel
                delegate: Rectangle{
                    id: bigDataRect
                    width: parent.width
                    height: 100

                    color: "transparent"

                    property alias playButtonImageSource: playButtonImage.source

                    Text{
                        id: indexText
                        width: 120
                        height: parent.height

                        text: index + 1
                        font.family: "微软雅黑"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: bigDataRect.left
                        anchors.leftMargin: 10
                    }

                    Image{
                        id: pic
                        width: parent.height - 10
                        height: parent.height - 10
                        source: al.picUrl
                        sourceSize: Qt.size(pic.width,pic.height)
                        cache: true
                        smooth: true
                        anchors.left: indexText.right
                        anchors.leftMargin: 20
                        anchors.top: indexText.top
                        anchors.topMargin: 5
                    }

                    Text{
                        id: songNameText
                        width: 400
                        height: parent.height

                        text: al.name
                        font.family: "微软雅黑"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: pic.right
                        anchors.leftMargin: 10
                    }

                    Rectangle{
                        id: playButtonRect

                        width: 100
                        height: parent.height
                        color: "transparent"

                        anchors.right: bigDataRect.right
                        anchors.rightMargin: 30

                        Image{
                            id: playButtonImage
                            source: "qrc:/images/resources/images/topN/play.png"
                            width: 30
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(playButtonImage.width,playButtonImage.width)
                            anchors.centerIn: parent
                            cache: true
                        }

                        RotationAnimation{
                            id: anitation
                            target: playButtonRect
                            from: 0
                            to: 360
                            duration: 800
                        }

                        MouseArea{
                            id: mouseArea

                            hoverEnabled: true
                            anchors.fill: parent

                            onEntered: {
                                anitation.start();
                            }

                            onClicked: {
                                clearAllSettings();
                                bigDataRect.color = "#33CCCCCC";
                                playButtonImageSource = "qrc:/images/resources/images/topN/playing.png";

                                mediaPlayer.setUrl("https://music.163.com/song/media/outer/url?id=" + id + ".mp3");

                                let node = bottomPlayControlLoader.item;
                                node.musicSongTextStr = al.name;
                                node.musicSongSingerTextStr = "";
                                node.templateSource = al.picUrl;
                                node.startPlayFlag();

                                let topNRealPageNode = topNRealPageLoader.item;
                                topNRealPageNode.startFlag = true;
                            }
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
        anchors.bottom: musicDetailRect.bottom

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
        commonCodeDealDetailPage();
    }


    onMusicIdChanged: {
        loadingImage.visible = true;
        commonCodeDealDetailPage();
    }
}
