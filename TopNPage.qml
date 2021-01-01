import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "qrc:/js/resources/javascript/Ajax.js" as Ajax

Rectangle{
    id: topNRect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3

    property string guanFangTopNTextStr: qsTr("官方榜")
    property string teSeTopNTextStr: qsTr("特色榜")
    property string sceneTopNTextStr: qsTr("场景榜")

    color: "transparent"

    ListModel{
        id: guanFangTopNModel
    }

    ListModel{
        id: teSeTopNModel
    }

    ListModel{
        id: sceneTopNModel
    }

    ScrollView{
        id: scrollView

        width: topNRect.width
        height: topNRect.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        ColumnLayout{
            id: columnLatout

            TopNTemplateView{
                id: guanFangView
                topNRectNode: scrollView
                topNTextStr: guanFangTopNTextStr
                topNModel: guanFangTopNModel
            }

            TopNTemplateView{
                id: teSeView
                topNRectNode: scrollView
                topNTextStr: teSeTopNTextStr
                topNModel: teSeTopNModel
            }

            TopNTemplateView{
                id: sceneView
                topNRectNode: scrollView
                topNTextStr: sceneTopNTextStr
                topNModel: sceneTopNModel
                Layout.alignment: Qt.AlignJustify
            }
        }
    }

    Component.onCompleted: {
        let topNTags = jsonUtil.getJsonArray("resources/topN.json");

        //官方榜
        let guanFangList = topNTags[0]["官方榜"];

        for (let i=0;i<guanFangList.length;i++){
            guanFangTopNModel.append(guanFangList[i]);
        }

        //特色榜
        let teSeList = topNTags[1]["特色榜"];

        for (let i=0;i<teSeList.length;i++){
            teSeTopNModel.append(teSeList[i]);
        }

        //场景榜
        let sceneList = topNTags[2]["场景榜"];

        for (let i=0;i<sceneList.length;i++){
            sceneTopNModel.append(sceneList[i]);
        }

        console.log(JSON.stringify(topNTags))
    }
}
