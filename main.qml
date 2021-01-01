import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer
import "qrc:/js/resources/javascript/Utils.js" as Utils

Window {
    id: window
    visible: true
    objectName: "window"
    width: 1224
    height: 764
    title: qsTr("酷我音乐")
    flags: Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
           | Qt.WindowMinimizeButtonHint| Qt.Window

    property var loaders: [recommendPageCenterAreaLoader,moviePageCenterAreaLoader
            ,tagPlayListPageCenterAreaLoader,topNPageCenterAreaLoader,topNRealPageLoader
            ,musicDetailPageLoader,[],downloadPageCenterAreaLoader]

    ListModel{
        id: sliderPngsModel
    }

    ListModel{
        id: leftAreaTag
    }

    //最底层响应拖拽窗体
    Loader{
        id: fullAreaLoader
        source: "FullAreaDeep.qml"
    }

    Rectangle{
        id: fullRect
        width: window.width - 6
        height: window.height - 6

        color: "transparent"

        //左侧区域
        Loader{
            id: leftAreaRectTagsLoader
            source: "LeftAreaRectTags.qml"
        }

        //centerArea
        Loader{
            id: recommendPageCenterAreaLoader
            x: 220
            y: 80
            source:  "RecommendPage.qml"
            onLoaded: {
                console.log(recommendPageCenterAreaLoader.item.sortText)
            }
        }

        Loader{
            id: moviePageCenterAreaLoader
            x: 220
            y: 80
            source: "MoviePage.qml"
        }

        Loader{
            id: tagPlayListPageCenterAreaLoader
            x: 220
            y: 80
            source: "TagPlayListPage.qml"
        }

        Loader{
            id: downloadPageCenterAreaLoader
            x: 220
            y: 80
            source: "DownloadPage.qml"
        }

        Loader{
            id: topNPageCenterAreaLoader
            x: 220
            y: 80
            source: "TopNPage.qml"
        }

        Loader{
            id: topNRealPageLoader
            x: 220
            y: 80
            source: "TopNRealPage.qml"
        }

        Loader{
            id: musicDetailPageLoader
            x: 220
            y: 80
            source: "MusicDetailPage.qml"
        }

        Loader{
            id: hotSearchTopLoader
            source: "HotSearchHeader.qml"
        }

        //bottomArea
        Loader{
            id: bottomPlayControlLoader
            source: "BottonPlayerArea.qml"
            anchors.top: leftAreaRectTagsLoader.bottom
        }
    }



    Component.onCompleted: {
        let imageList = jsonReader.getSliderPngs(app);
        let imageListSize = jsonReader.getListSize(imageList);
        for (let i=0;i<imageListSize;i++){
            sliderPngsModel.append({"imageSrc":jsonReader.getListByIndex(imageList,i)});
        }

        //加载leftArea的tag标签数据
        let leftAreaConfigJson = jsonReader.getLeftAreaConfigJson();

        for (let i=0;i<leftAreaConfigJson.length;i++){
            leftAreaTag.append(leftAreaConfigJson[i]);
            leftAreaConfigJson[i]["index"] = i;
        }

        let node = bottomPlayControlLoader.item;
        let topNRealPageNode = topNRealPageLoader.item;
        Timer.setInterval(function(){
            if (topNRealPageNode.startFlag){
                node.progressTimeTotalTextStr = Timer.timeToMinute(mediaPlayer.duration);
                node.progressTimeSpanTextStr = Timer.timeToMinute(mediaPlayer.position);
                node.progressingBarRectWidth = (mediaPlayer.position / mediaPlayer.duration) * node.playLengthRectWidth;
            }
        },500);
    }
}



