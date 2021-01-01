import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.10
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer
import "qrc:/js/resources/javascript/Utils.js" as Utils

Rectangle{
    id: tagPlayListOuterRect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3

    color: "transparent"

    property var tagPlayLists: []
    property int currentIndex : -1
    property bool isClick: false
    property int pageIndex: 1
    property int pageNumber: 30
    property string tagName: "华语"
    property bool flag: true
    property string loadingTextStr: "数据加载中......"

    function clearColorWithChildren(){
        let count = tagGridView.count;

        for (let i=0;i<count;i++){
            let model = tagListModel.get(i);
            if (currentIndex !== i){
                model.itemColor = "transparent";
            }
            else{
                if (isClick){
                    model.itemColor = "#ffe12c";
                }
            }
        }
    }

    ListModel{
        id: tagListModel
    }

    ListModel{
        id: singleMusicsModel
    }

    AnimatedImage{
        id: loadingImage
        source: "qrc:/images/resources/images/moviePage/loading.gif"
        anchors.centerIn: parent
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
                loadingText.visible = true;

                Ajax.get("http://musicapi.leanapp.cn/top/playlist?limit=" +pageNumber+ "&offset=" + pageIndex * pageNumber+ "&order=new&cat=" + tagName,function(result,data){
                    let singleMusicList = data.playlists;
                    for (let i=0;i<singleMusicList.length;i++){
                        singleMusicsModel.append({
                                                     "name" : singleMusicList[i].name,
                                                     "coverImgUrl" : singleMusicList[i].coverImgUrl,
                                                     "description" : singleMusicList[i].description,
                                                     "id" :  singleMusicList[i].id
                                                 });
                    }


                    loadingText.visible = false;

                    Timer.setTimeout(function(){
                        flag = true;
                    },1000);
                },function(){});
            }
        }

        ColumnLayout{
            id: layout
            width: parent.width
            height: parent.height

            Rectangle{
                id: tagRect
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 320

                color: "#000000"

                GridView{
                    id: tagGridView
                    width: parent.width
                    height: parent.height
                    cellWidth: 110
                    cellHeight: 40

                    model: tagListModel

                    delegate: Rectangle{
                        id: innerTagRect
                        width: tagGridView.cellWidth
                        height: tagGridView.cellHeight

                        color: itemColor
                        radius: 6

                        Text{
                            id: tagText
                            width: parent.width
                            height: parent.height

                            font.pixelSize: 16
                            text: name
                            font.family: "微软雅黑"

                            color: "#FFFFFF"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea{
                            id: tagMouseArea
                            anchors.fill: parent

                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onEntered: {
                                clearColorWithChildren();
                                itemColor = "#ffe12c";
                            }

                            onExited: {
                                clearColorWithChildren();
                            }

                            onClicked: {
                                currentIndex = index;
                                isClick = true;
                                clearColorWithChildren();
                                itemColor = "#ffe12c";
                                tagName = name;
                                pageIndex = 0;
                            }
                        }
                    }
                }
            }


            GridView{
                id: singleMusicsGridView
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: Math.ceil(singleMusicsGridView.count  * 1.0 / Math.floor(singleMusicsGridView.width * 1.0 / singleMusicsGridView.cellWidth * 1.0)) * singleMusicsGridView.cellHeight
                cellWidth: 193
                cellHeight: 193

                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 10

                model: singleMusicsModel
                delegate: Rectangle{
                    id: innerSingleMusicRect

                    width: singleMusicsGridView.cellWidth
                    height: singleMusicsGridView.cellHeight

                    color: "transparent"

                    clip: true

                    Image{
                        id: innerImage
                        height: parent.height - 5
                        source: coverImgUrl

                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignHCenter
                        anchors.top: innerSingleMusicRect.top
                        sourceSize: Qt.size(innerImage.height,innerImage.height)
                    }

                    Image{
                        id: playImage
                        source: "qrc:/images/resources/images/moviePage/play.png"
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        visible: false
                        cache: true
                    }


                    Text{
                        id: nameText
                        width: parent.width
                        height: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottom: innerSingleMusicRect.bottom
                        anchors.bottomMargin: 20
                        font.family: "微软雅黑"
                        font.pixelSize: 15
                        text: name.length > 8 ? name.substr(0,8) + "..." : name
                    }

                    Text{
                        id: unameText
                        width: parent.width
                        height: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottom: innerSingleMusicRect.bottom
                        anchors.bottomMargin: 5
                        font.family: "微软雅黑"
                        font.pixelSize: 15
                        text: description
                    }

                    ScaleAnimator{
                        id: scale1_1_2Animator
                        target: innerImage
                        from: 1
                        to: 1.2
                        duration: 800
                    }

                    ScaleAnimator{
                        id: scale1_2_1Animator
                        target: innerImage
                        from: 1.2
                        to: 1
                        duration: 800
                    }

                    MouseArea{
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            playImage.visible = true;
                            scale1_1_2Animator.start();
                        }

                        onExited: {
                            playImage.visible = false;
                            scale1_2_1Animator.start();
                        }

                        onClicked: {
                            musicDetailPageLoader.item.musicId = id;
                            Utils.setAllLoadersUnVisible();
                            musicDetailPageLoader.visible = true;
                            leftAreaRectTagsLoader.item.musicDetail = uuidUtil.getUUID();
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
        anchors.bottom: tagPlayListOuterRect.bottom

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

        Ajax.get("http://musicapi.leanapp.cn/playlist/catlist",function(response,data){
            let tagPlayHeaderJson = data.sub;
            for (let i=0;i<tagPlayHeaderJson.length;i++){
                tagPlayHeaderJson[i].index = i;
                tagPlayHeaderJson[i].itemColor = "transparent";
                tagListModel.append(tagPlayHeaderJson[i]);
            }

            //定位到tag的标签
            tagListModel.get(3).itemColor = "#ffe12c";
            currentIndex = 3;
            isClick = true;
        },function(){});

        //获取单曲的列表
        Ajax.get("http://musicapi.leanapp.cn/top/playlist?limit=" +pageNumber+ "&offset=" + pageIndex * pageNumber+ "&order=new&cat=" + tagName,function(response,data){
            let singleMusicList = data.playlists;
            for (let i=0;i<singleMusicList.length;i++){
                singleMusicsModel.append({
                                             "name" : singleMusicList[i].name,
                                             "coverImgUrl" : singleMusicList[i].coverImgUrl,
                                             "description" : singleMusicList[i].description,
                                             "id" :  singleMusicList[i].id
                                         });
            }

            loadingImage.visible = false;
            loadingText.visible = false;
        },function(){});

    }

    onTagNameChanged: {
        //获取单曲的列表
        loadingImage.visible = true;
        singleMusicsModel.clear();
        Ajax.get("http://musicapi.leanapp.cn/top/playlist?limit=" +pageNumber+ "&offset=" + pageIndex * pageNumber+ "&order=new&cat=" + tagName,function(response,data){
            let singleMusicList = data.playlists;
            for (let i=0;i<singleMusicList.length;i++){
                singleMusicsModel.append({
                                             "name" : singleMusicList[i].name,
                                             "coverImgUrl" : singleMusicList[i].coverImgUrl,
                                             "description" : singleMusicList[i].description,
                                             "id" :  singleMusicList[i].id
                                         });
            }

            loadingImage.visible = false;
            loadingText.visible = false;
        },function(){});
    }
}

