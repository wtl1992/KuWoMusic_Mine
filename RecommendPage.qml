import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import "qrc:/js/resources/javascript/Ajax.js" as Ajax

Component {

    Rectangle{

        property int scrollImageWidth: parent.width - 300
        property int firstImagePosX: 0
        property int secondImagePosX: 140
        property int thirdImagePosX: 270
        property int sliderImagePosY: 20

        property var firstSliderImage: image1
        property var secondSliderImage: image2
        property var thirdSliderImage: image3

        property int month
        property int day
        property int year

        property int sliderDuration: 1500


        property string sortText: qsTr("排行榜")
        property string singerText: qsTr("歌手")
        property string musicText: qsTr("歌单")
        property string mvText: qsTr("MV")

        property string fontFamily: qsTr("微软雅黑")

        property var sliderRects: [itemRect1,itemRect2,itemRect3,itemRect4]

        property string personRecommendTextStr: qsTr("个性推荐")
        property string moreTextStr: qsTr("更多")
        property string listenTextStr: qsTr("大家都在听")
        property string dayingRecommendTextStr: qsTr("每日歌曲推荐")
        property string singleMusicTextStr: qsTr("最新单曲推荐")

        property string dayingRecommentTextStr: qsTr("每日推荐")
        property string newSingleMusicTextStr: qsTr("最新单曲")
        property string topNTextStr: qsTr("排行榜")

        property var singleMusicList: []

        property var topNImages

        property var oumeiListModel: ListModel{}
        property var hotSongListModel: ListModel{}
        property var riHanListModel: ListModel{}
        property var newSongListModel: ListModel{}
        property var biaoShengListModel: ListModel{}

        property string singerRecommendTextStr: qsTr("歌手推荐")

        function setInterval(callback,timeout){
            let timer = Qt.createQmlObject("import QtQuick 2.14; Timer {}", window);
            timer.interval = timeout;
            timer.repeat = true;
            timer.triggered.connect(callback);
            timer.start();
        }

        function clearSliderRect(){
            for (let i=0;i<sliderRects.length;i++){
                sliderRects[i].color = "transparent";
            }
        }

        width: window.width - 226
        //减去头和bottom
        height: window.height - 80 - 60 - 3
        ScrollView{
            id: scrollView
            width: parent.width
            height: parent.height
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ColumnLayout{
                id: columnLayout
                width: scrollView.width
                height: parent.height
                Rectangle{
                    id: recommendRect
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 260
                    color: "transparent"

                    Row{
                        id: topAreaTagsRow
                        width: parent.width - 560
                        height: 50
                        x: (parent.width - topAreaTagsRow.width) / 2

                        spacing: 10

                        Rectangle{
                            id: itemRect1
                            width: parent.width / 4
                            height: parent.height

                            color: "transparent"

                            Text{
                                text: sortText
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                                font.family: fontFamily
                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onEntered: {
                                        parent.color = "#CCCCCC";
                                    }

                                    onExited: {
                                        parent.color = "#000000";
                                    }

                                    onClicked: {
                                        clearSliderRect();
                                        parent.parent.color = "#FFD200";
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: itemRect2
                            width: parent.width / 4
                            height: parent.height

                            color: "transparent"

                            Text{
                                text: singerText
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                                font.family: fontFamily
                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onEntered: {
                                        parent.color = "#CCCCCC";
                                    }

                                    onExited: {
                                        parent.color = "#000000";
                                    }

                                    onClicked: {
                                        clearSliderRect();
                                        parent.parent.color = "#FFD200";
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: itemRect3
                            width: parent.width / 4
                            height: parent.height

                            color: "transparent"

                            Text{
                                text: musicText
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                                font.family: fontFamily
                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onEntered: {
                                        parent.color = "#CCCCCC";
                                    }

                                    onExited: {
                                        parent.color = "#000000";
                                    }

                                    onClicked: {
                                        clearSliderRect();
                                        parent.parent.color = "#FFD200";
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: itemRect4
                            width: parent.width / 4
                            height: parent.height

                            color: "transparent"

                            Text{
                                text: mvText
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                                font.family: fontFamily

                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onEntered: {
                                        parent.color = "#CCCCCC";
                                    }

                                    onExited: {
                                        parent.color = "#000000";
                                    }

                                    onClicked: {
                                        clearSliderRect();
                                        parent.parent.color = "#FFD200";
                                    }
                                }
                            }
                        }
                    }


                    //slider图片区域
                    Rectangle{
                        id: topSliderRect
                        width: parent.width
                        height: 200
                        color: "transparent"

                        anchors.top: topAreaTagsRow.bottom

                        Timer{
                            id: sliderTimer
                        }

                        ParallelAnimation{
                            id: sliderParallelAnimation
                            PropertyAnimation{
                                id: firstScaleAnimation
                                target: firstSliderImage
                                property: "scale"
                                from: 1.05
                                to: 0.8
                                duration: sliderDuration
                            }
                            PropertyAnimation{
                                id: firstPosXAnimation
                                target: firstSliderImage
                                property: "x"
                                from: secondImagePosX
                                to: firstImagePosX
                                duration: sliderDuration
                            }

                            PropertyAnimation{
                                id: secondScaleAnimation
                                target: secondSliderImage
                                property: "scale"
                                from: 1
                                to: 1.05
                                duration: sliderDuration
                            }
                            PropertyAnimation{
                                id: secondPosXAnimation
                                target: secondSliderImage
                                property: "x"
                                from: thirdImagePosX
                                to: secondImagePosX
                                duration: sliderDuration
                            }

                            PropertyAnimation{
                                id: thirdScaleAnimation
                                target: thirdSliderImage
                                property: "scale"
                                from: 1.05
                                to: 0.8
                                duration: sliderDuration
                            }
                            PropertyAnimation{
                                id: thirdPosXAnimation
                                target: thirdSliderImage
                                property: "x"
                                from: secondImagePosX
                                to: thirdImagePosX
                                duration: sliderDuration
                            }
                        }

                        Image{
                            id: image1
                            source: "qrc:/images/resources/images/sliderPngs/scroll1.jpg"
                            width: scrollImageWidth
                            x: firstImagePosX
                            y: sliderImagePosY
                            fillMode: Image.PreserveAspectFit
                            scale: 0.8
                        }

                        Image{
                            id: image2
                            source: "qrc:/images/resources/images/sliderPngs/scroll2.jpg"
                            width: scrollImageWidth
                            x: secondImagePosX
                            y: sliderImagePosY
                            z: 100
                            fillMode: Image.PreserveAspectFit
                        }

                        Image{
                            id: image3
                            source: "qrc:/images/resources/images/sliderPngs/scroll3.jpg"
                            width: scrollImageWidth
                            x: thirdImagePosX
                            y: sliderImagePosY
                            fillMode: Image.PreserveAspectFit
                            scale: 0.8
                        }

                        Image{
                            id: image4
                            source: "qrc:/images/resources/images/sliderPngs/scroll4.jpg"
                            width: scrollImageWidth
                            x: thirdImagePosX
                            y: sliderImagePosY
                            fillMode: Image.PreserveAspectFit
                            visible: false
                        }
                    }
                }

                //个人推荐区域
                Rectangle{
                    id: personRecommendRect
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 460
                    color: "transparent"

                    Text{
                        id: personRecommendText
                        width: 60
                        height: 30
                        x: 10
                        text: personRecommendTextStr
                        font.pixelSize: 20
                        font.family: "Consolas"
                    }

                    Rectangle{
                        id: personRecommendTmpRect
                        width: 100
                        height: 30
                        color: "transparent"

                        anchors.right: personRecommendRect.right
                        anchors.rightMargin: 30
                        Image{
                            id: moreImage
                            width: 20
                            source: "qrc:/images/resources/images/recommendPage/more.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.right: personRecommendTmpRect.right
                        }

                        Text{
                            id: moreText
                            width: 60
                            height: 30
                            text: moreTextStr
                            anchors.right: moreImage.left
                            font.pixelSize: 20
                            font.family: "Consolas"
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            ToolTip.text: moreTextStr
                            onEntered: {
                                ToolTip.visible = true;
                            }

                            onExited: {
                                ToolTip.visible = false;
                            }
                        }
                    }

                    RadiusImage {
                        id: radiusImage1
                        imageWidth: 178
                        imageHeight: 112
                        anchorsTop: personRecommendTmpRect.bottom
                        anchorsLeft: personRecommendRect.left
                        leftMargin: 10
                        topMargin: 10
                        imageSource: "qrc:/images/resources/images/recommendPage/hotMusic0.png"
                        imageRasdius: 6

                        Image{
                            id: innerImage
                            width: 30
                            source: "qrc:/images/resources/images/recommendPage/change.png"
                            smooth: true
                            fillMode: Image.PreserveAspectFit
                            anchors.right: radiusImage1.right
                            anchors.bottom: radiusImage1.bottom
                            anchors.rightMargin: 5
                            anchors.bottomMargin: 10
                        }
                    }

                    RadiusImage {
                        id: radiusImage2
                        imageWidth: 178
                        imageHeight: 63
                        anchorsTop: radiusImage1.bottom
                        anchorsLeft: personRecommendRect.left
                        leftMargin: 10
                        topMargin: 10
                        imageSource: "qrc:/images/resources/images/recommendPage/hotComment.png"
                        imageRasdius: 6
                    }

                    Item{
                        id: listenItem
                        width: 60
                        height: 30
                        anchors.top: radiusImage2.bottom
                        anchors.left: radiusImage2.left
                        anchors.topMargin: 6

                        Text {
                            id: listenText
                            text: listenTextStr
                            font.pixelSize: 14
                            font.family: "Consolas"
                        }
                    }

                    RadiusImage {
                        id: dayingRecommendRadiusImage
                        imageWidth: 178
                        imageHeight: 178
                        anchorsTop: radiusImage1.top
                        anchorsLeft: radiusImage2.right
                        leftMargin: 10
                        topMargin: 0
                        imageSource: "qrc:/images/resources/images/recommendPage/dayRecommend.png"
                        imageRasdius: 6

                        Item{
                            id: dayingRecommendItem
                            width: 60
                            height: 30
                            anchors.top: dayingRecommendRadiusImage.bottom
                            anchors.left: dayingRecommendRadiusImage.left
                            anchors.topMargin: 6

                            Text {
                                id: dayingRecommendText
                                text: dayingRecommendTextStr
                                font.pixelSize: 14
                                font.family: "Consolas"
                            }
                        }

                        Text{
                            id: yearText
                            text: year
                            font.pixelSize: 26
                            font.family: "Consolas"
                            x: 10
                            y: 48
                            color: "#FFFFFF"
                        }

                        Text{
                            id: monthText
                            text: month
                            font.pixelSize: 26
                            font.family: "Consolas"
                            x: 10
                            y: 78
                            color: "#FFFFFF"
                        }

                        Text{
                            id: dayText
                            text: day
                            font.pixelSize: 26
                            font.family: "Consolas"
                            x: 10
                            y: 100
                            color: "#FFFFFF"
                        }

                        Text{
                            id: dayingRecommentText
                            text: dayingRecommentTextStr
                            font.pixelSize: 26
                            font.family: "微软雅黑"
                            x: 10
                            y: 130
                            color: "#FFFFFF"
                        }
                    }

                    RadiusImage {
                        id: singleMusicRadiusImage
                        imageWidth: 178
                        imageHeight: 178
                        anchorsTop: radiusImage1.top
                        anchorsLeft: dayingRecommendRadiusImage.right
                        leftMargin: 10
                        topMargin: 0
                        imageSource: "qrc:/images/resources/images/recommendPage/singleMusic.jpg"
                        imageRasdius: 6

                        Item{
                            id: singleMusicItem
                            width: 60
                            height: 30
                            anchors.top: singleMusicRadiusImage.bottom
                            anchors.left: singleMusicRadiusImage.left
                            anchors.topMargin: 6

                            Text {
                                id: singleMusicText
                                text: singleMusicTextStr
                                font.pixelSize: 14
                                font.family: "Consolas"
                            }
                        }


                        Text{
                            id: newSingleMusicText
                            text: newSingleMusicTextStr
                            font.pixelSize: 28
                            font.family: "微软雅黑"
                            anchors.bottom: singleMusicRadiusImage.bottom
                            anchors.bottomMargin: 20
                            x: 10
                            color: "#FFFFFF"
                        }
                    }

                    RadiusImage {
                        id: singleMusic1RadiusImage
                        imageWidth: 178
                        imageHeight: 178
                        anchorsTop: radiusImage1.top
                        anchorsLeft: singleMusicRadiusImage.right
                        leftMargin: 10
                        topMargin: 0
                        imageSource: singleMusicList.length > 0 ? singleMusicList[0].img : ""
                        imageRasdius: 6

                        Item{
                            id: singleMusic1Item
                            width: 60
                            height: 30
                            anchors.top: singleMusic1RadiusImage.bottom
                            anchors.left: singleMusic1RadiusImage.left
                            anchors.topMargin: 6

                            Text {
                                id: singleMusic1Text
                                text: singleMusicList.length > 0 ? singleMusicList[0].name : ""
                                font.pixelSize: 14
                                font.family: "Consolas"
                            }
                        }


                        Text{
                            id: newSingleMusic1Text
                            text: singleMusicList.length > 0 ? singleMusicList[0].uid : ""
                            font.pixelSize: 28
                            font.family: "微软雅黑"
                            anchors.bottom: singleMusic1RadiusImage.bottom
                            anchors.bottomMargin: 20
                            x: 10
                            color: "#FFFFFF"
                        }
                    }

                    RadiusImage {
                        id: singleMusic2RadiusImage
                        imageWidth: 178
                        imageHeight: 178
                        anchorsTop: radiusImage1.top
                        anchorsLeft: singleMusic1RadiusImage.right
                        leftMargin: 10
                        topMargin: 0
                        imageSource: singleMusicList.length > 0 ? singleMusicList[1].img : ""
                        imageRasdius: 6

                        Item{
                            id: singleMusic2Item
                            width: 60
                            height: 30
                            anchors.top: singleMusic2RadiusImage.bottom
                            anchors.left: singleMusic2RadiusImage.left
                            anchors.topMargin: 6

                            Text {
                                id: singleMusic2Text
                                text: singleMusicList.length > 0 ? singleMusicList[1].name : ""
                                font.pixelSize: 14
                                font.family: "Consolas"
                            }
                        }


                        Text{
                            id: newSingleMusic2Text
                            text: singleMusicList.length > 0 ? singleMusicList[1].uid : ""
                            font.pixelSize: 28
                            font.family: "微软雅黑"
                            anchors.bottom: singleMusic2RadiusImage.bottom
                            anchors.bottomMargin: 20
                            x: 10
                            color: "#FFFFFF"
                        }
                    }


                    ListModel{
                        id: singleMusicsModel
                    }

                    GridView{
                        id: singleMusicsGridView
                        model: singleMusicsModel
                        width: parent.width
                        anchors.top: singleMusic2RadiusImage.bottom
                        anchors.topMargin: 30

                        cellWidth: 190
                        cellHeight: 190
                        delegate: Rectangle{
                            id: innerRect
                            width: singleMusicsGridView.cellWidth
                            height: singleMusicsGridView.cellHeight
                            color: "transparent"

                            Item{
                                id: item
                                width: 178
                                height: 178
                                anchors.centerIn: parent
                                Image{
                                    id: innerSingleImage
                                    smooth: true
                                    visible: false
                                    anchors.fill: parent
                                    source: img
                                    sourceSize: Qt.size(parent.size, parent.size)
                                    antialiasing: true
                                }

                                Rectangle {
                                    id: innerSingleMusicRect
                                    color: "black"
                                    anchors.fill: parent
                                    radius: 7
                                    visible: false
                                    antialiasing: true
                                    smooth: true
                                }
                                OpacityMask {
                                    id: hotMusicOpcityMask
                                    anchors.fill: innerSingleImage
                                    source: innerSingleImage
                                    maskSource: innerSingleMusicRect
                                    visible: true
                                    antialiasing: true
                                }
                            }

                            Item{
                                id: singleMItem
                                width: 60
                                height: 30
                                anchors.top: innerRect.bottom
                                anchors.left: innerRect.left
                                anchors.topMargin: 6

                                Text {
                                    id: singleMText
                                    text: name
                                    font.pixelSize: 14
                                    font.family: "Consolas"
                                }
                            }


                            Text{
                                id: newSingleMText
                                text: uid
                                font.pixelSize: 28
                                font.family: "微软雅黑"
                                anchors.bottom: innerRect.bottom
                                anchors.bottomMargin: 20
                                x: 10
                                color: "#FFFFFF"
                            }
                        }
                    }
                }

                //TopN区域
                Rectangle{
                    id: topNRect
                    width: parent.width
                    height: 565
                    color: "transparent"

                    Text{
                        id: topNText
                        width: 50
                        height:30
                        font.pixelSize: 26
                        font.family: "微软雅黑"
                        text: topNTextStr
                        x: 10
                        y: 10
                    }

                    ListModel{
                        id: topNModel
                    }

                    GridView{
                        id: topNGridView
                        width: parent.width
                        height: 98
                        anchors.top: topNText.bottom
                        anchors.topMargin: 5
                        cellWidth: 198
                        cellHeight: topNGridView.height

                        model: topNModel

                        delegate: Rectangle{
                            id: innerTopNRect
                            width: topNGridView.cellWidth
                            height: topNGridView.cellHeight

                            color: "black"

                            Image{
                                id: topNMusicImage
                                width: parent.width - 10
                                fillMode: Image.PreserveAspectFit
                                source: img
                            }
                        }
                    }


                    //欧美模块
                    TopNTemplate{
                        id: oumeiTopNTemplate
                        listModel: oumeiListModel
                        gridViewBottom: topNGridView.bottom
                        listViewRight: topNGridView.left
                    }

                    //热歌模块
                    TopNTemplate{
                        id: hotSongTopNTemplate
                        listModel: hotSongListModel
                        gridViewBottom: topNGridView.bottom
                        listViewRight: oumeiTopNTemplate.right
                    }

                    //日韩模块
                    TopNTemplate{
                        id: riHanTopNTemplate
                        listModel: riHanListModel
                        gridViewBottom: topNGridView.bottom
                        listViewRight: hotSongTopNTemplate.right
                    }

                    //新歌模块
                    TopNTemplate{
                        id: newSongTopNTemplate
                        listModel: newSongListModel
                        gridViewBottom: topNGridView.bottom
                        listViewRight: riHanTopNTemplate.right
                    }

                    //飙升模块
                    TopNTemplate{
                        id: biaoShengTopNTemplate
                        listModel: biaoShengListModel
                        gridViewBottom: topNGridView.bottom
                        listViewRight: newSongTopNTemplate.right
                    }

                }


                Rectangle{
                    id: singerRecommendRect
                    width: parent.width
                    height: 525

                    color: "transparent"


                    Text{
                        id: singerRecommendText
                        width: 50
                        height:30
                        font.pixelSize: 26
                        font.family: "微软雅黑"
                        text: singerRecommendTextStr
                        x: 10
                        y: 10
                    }

                    ListModel{
                        id: singerRecommendListModel
                    }

                    GridView{
                        id: singerRecommendGridView
                        width: parent.width
                        height: parent.height

                        anchors.top: singerRecommendText.bottom
                        anchors.topMargin: 10

                        cellWidth: 199
                        cellHeight: 236

                        model: singerRecommendListModel
                        delegate: Rectangle{
                            id: singerRecommendInnerRect
                            width: singerRecommendGridView.cellWidth
                            height: singerRecommendGridView.cellHeight

                            color: "transparent"

                            Rectangle{
                                id: innerSingerRecommendRect
                                width: parent.width - 10
                                height: parent.width - 10

                                anchors.top: parent.top

                                color: "transparent"
                                Image {
                                    id: singerRecommendImage
                                    smooth: true
                                    visible: false
                                    anchors.fill: parent
                                    source: pic
                                    sourceSize: Qt.size(parent.size, parent.size)
                                    antialiasing: true
                                }
                                Rectangle {
                                    id: singerRect
                                    color: "black"
                                    anchors.fill: parent
                                    radius: parent.width / 2
                                    visible: false
                                    antialiasing: true
                                    smooth: true
                                }
                                OpacityMask {
                                    id: singerRecommendOpcityMask
                                    anchors.fill: singerRecommendImage
                                    source: singerRecommendImage
                                    maskSource: singerRect
                                    visible: true
                                    antialiasing: true
                                }

                                Text{
                                    id: singerNameText
                                    width: innerSingerRecommendRect.width
                                    height: 26
                                    font.pixelSize: 18
                                    font.family: "微软雅黑"
                                    text: name
                                    anchors.left: innerSingerRecommendRect.left
                                    anchors.top: innerSingerRecommendRect.bottom

                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                Text{
                                    id: singerMusicNumText
                                    width: innerSingerRecommendRect.width
                                    height: 12
                                    font.pixelSize: 12
                                    font.family: "微软雅黑"
                                    text: musicNum + "首歌曲"
                                    anchors.left: innerSingerRecommendRect.left
                                    anchors.top: singerNameText.bottom

                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            let sliderImages = [image1,image2,image3,image4];
            let num = 0;
            setInterval(function(){
                num ++;
                for (let i=0;i<sliderImages.length;i++){
                    sliderImages[i].visible = "true";
                    sliderImages[i].z = 0;
                }

                let index = num % sliderImages.length;
                firstSliderImage = sliderImages[index];
                secondSliderImage = sliderImages[(index + 1) % sliderImages.length];
                thirdSliderImage = sliderImages[(index + 2) % sliderImages.length];

                firstSliderImage.z = 2;
                secondSliderImage.z= 3;
                thirdSliderImage.z = 1;


                sliderImages[(index + 3) % sliderImages.length].visible = false;
                sliderParallelAnimation.start();
            },2000);


            //获取系统时间
            let dateTimeStr = dateTimeUtil.getDateTimeStr();
            let splits = dateTimeStr.split(" ")[0].split(":");
            year = splits[0];
            month = splits[1];
            day = splits[2];

            //获取2个单曲
            Ajax.get("https://ljxwtl.cn/kuwo/recommend/1/2",function(response,data){
                let singleMusics = data.data.data;
                singleMusicList = singleMusics;
            },function(){});

            //获取5个单曲
            Ajax.get("https://ljxwtl.cn/kuwo/recommend/2/5",function(response,data){
                let singleMusics = data.data.data;
                for (let i=0;i<singleMusics.length;i++){
                    singleMusicsModel.append(singleMusics[i]);
                }
            },function(){});

            //获取排行榜的数据
            for (let i=0;i<5;i++){
                let songImageSrc = "qrc:/images/resources/images/recommendPage/song"+(i+1)+".png";
                topNModel.append({"img":songImageSrc,"index":i});
            }
            //第一列：欧美
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/158/1/5",function(response,data){
                let oumeiMusics = data.data.musicList;
                for (let i=0;i<oumeiMusics.length;i++){
                    oumeiListModel.append(oumeiMusics[i]);
                }
            },function(){});

            //第二列：热歌
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/93/1/5",function(response,data){
                let hotSongMusics = data.data.musicList;
                for (let i=0;i<hotSongMusics.length;i++){
                    hotSongListModel.append(hotSongMusics[i]);
                }
            },function(){});

            //第三列：日韩
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/279/1/5",function(response,data){
                let riHanMusics = data.data.musicList;
                for (let i=0;i<riHanMusics.length;i++){
                    riHanListModel.append(riHanMusics[i]);
                }
            },function(){});

            //第四列：新歌
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/290/1/5",function(response,data){
                let newSongMusics = data.data.musicList;
                for (let i=0;i<newSongMusics.length;i++){
                    newSongListModel.append(newSongMusics[i]);
                }
            },function(){});

            //第五列：飙升
            Ajax.get("https://ljxwtl.cn/kuwo/leaderBoard/17/1/5",function(response,data){
                let biaoShengMusics = data.data.musicList;
                for (let i=0;i<biaoShengMusics.length;i++){
                    biaoShengListModel.append(biaoShengMusics[i]);
                }
            },function(){});

            //获取歌手推荐
            Ajax.get("https://ljxwtl.cn/kuwo/artistInfo/0/6/10?prefix=",function(response,data){
                let singerRecommends = data.data.artistList;
                for (let i=0;i<singerRecommends.length;i++){
                    singerRecommendListModel.append(singerRecommends[i]);
                }

                console.log(singerRecommendListModel.count)
            },function(){});
        }
    }
}
