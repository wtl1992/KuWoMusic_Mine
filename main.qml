import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    id: window
    visible: true
    objectName: "window"
    width: 1224
    height: 764
    title: qsTr("酷我音乐")

    property var currentPage: RecommendPage{}

    ListModel{
        id: sliderPngsModel
    }

    ListModel{
        id: leftAreaTag
    }

    //最底层响应拖拽窗体
    //        Loader{
    //            id: fullAreaLoader
    //            source: "FullAreaDeep.qml"
    //        }

    Rectangle{
        id: fullRect
        width: window.width - 6
        height: window.height - 6
        x: 3
        y: 3


        //左侧区域
        Loader{
            id: leftAreaRectTagsLoader
            source: "LeftAreaRectTags.qml"
        }

        //centerArea
        Loader{
            id: centerAreaLoader
            x: 220
            y: 80
            sourceComponent: currentPage
        }

        Loader{
            id: hotSearchTopLoader
            source: "HotSearchHeader.qml"
        }

        //bottomArea
        //        Loader{
        //            id: bottomPlayControlLoader
        //            sourceComponent: BottonPlayControl{}
        //        }
    }



    Component.onCompleted: {
        let imageList = jsonReader.getSliderPngs(app);
        let imageListSize = jsonReader.getListSize(imageList);
        for (let i=0;i<imageListSize;i++){
            sliderPngsModel.append({"imageSrc":jsonReader.getListByIndex(imageList,i)});
        }

        //加载leftArea的tag标签数据
        let leftAreaConfigJsonList = jsonReader.getLeftAreaConfigJson();
        console.log(leftAreaConfigJsonList)
        let leftAreaConfigJson = JSON.parse(leftAreaConfigJsonList);

        for (let i=0;i<leftAreaConfigJson.length;i++){
            leftAreaTag.append(leftAreaConfigJson[i]);
            leftAreaConfigJson[i]["index"] = i;
        }


        console.log(leftAreaTag.count)

    }
}



