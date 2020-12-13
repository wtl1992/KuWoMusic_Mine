import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    objectName: "window"
    width: 1224
    height: 764
    title: qsTr("酷我音乐")



    ListModel{
       id: leftAreaTag
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



