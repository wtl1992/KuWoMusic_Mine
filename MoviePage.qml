import QtQuick 2.14
import QtQuick.Controls 2.14
import "qrc:/js/resources/javascript/Ajax.js" as Ajax
import "qrc:/js/resources/javascript/Timer.js" as Timer
import "qrc:/js/resources/javascript/Utils.js" as Utils

Rectangle{
    id: movieOuterRect

    width: window.width - 226
    //减去头和bottom
    height: window.height - 80 - 60 - 3
    color: "transparent"

    property int currentIndex : -1
    property bool isClick: false
    property string fromColor
    property string toColor
    property int pageIndex: 1
    property bool flag: true
    property string loadingTextStr: "数据加载中......"


    function clearColorWithChildren(){
        let count = headerGridView.count;

        for (let i=0;i<count;i++){
            let model = headerListModel.get(i);
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


    AnimatedImage{
        id: loadingImage
        source: "qrc:/images/resources/images/moviePage/loading.gif"
        anchors.centerIn: parent
    }

    ListModel{
        id: headerListModel
    }

    ScrollView{
        id: scrollView
        width: parent.width
        height: parent.height

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        GridView{
            id: headerGridView
            width: parent.width
            height: 250
            x: 20
            y: 10

            cellWidth: 110
            cellHeight: 30

            model: headerListModel

            delegate: Rectangle{
                id: innerRect
                width: headerGridView.cellWidth
                height: headerGridView.cellHeight

                color: itemColor

                Text {
                    id: headerText
                    text: qsTr(name)
                    font.family: "微软雅黑"
                    font.pixelSize: 20
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea{
                    id: headerMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    cursorShape: Qt.PointingHandCursor

                    ToolTip.text: name

                    onEntered: {
                        clearColorWithChildren();
                        itemColor = "#ffe12c";

                        ToolTip.visible = true;
                    }

                    onExited: {
                        clearColorWithChildren();
                        ToolTip.visible = false;
                    }

                    onClicked: {
                        currentIndex = index;
                        isClick = true;
                        clearColorWithChildren();
                        itemColor = "#ffe12c";
                    }
                }
            }
        }

        ListModel{
            id: movieListModel
        }




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
                Ajax.get("https://ljxwtl.cn/kuwo/mvList/236682871/" + pageIndex + "/30",
                         function(result, data){
                             console.log(JSON.stringify(data))
                             let movieList = data.data.mvlist;
                             for (let i=0;i<movieList.length;i++){
                                 movieListModel.append(movieList[i]);
                             }

                             loadingText.visible = false;

                             Timer.setTimeout(function(){
                                 flag = true;
                             },1000);
                         },function(){

                         });
            }
        }



        GridView{
            id: movieGridView
            width: parent.width

            cellWidth: 330
            cellHeight: 200

            model: movieListModel
            clip: true


            delegate: Rectangle{
                id: innerMovieRect
                width: movieGridView.cellWidth
                height: movieGridView.cellHeight

                color: "transparent"
                border.width: 1
                border.color: "black"
                clip: true

                Image{
                    id: innerImage
                    source: pic
                    height: movieGridView.cellHeight - 20
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }

                Image{
                    id: playImage
                    source: "qrc:/images/resources/images/moviePage/play.png"
                    width: 50
                    height: 50
                    anchors.centerIn: parent
                    visible: false
                }

                Rectangle{
                    id: fullRect
                    width: 100
                    height: 30
                    color: "transparent"

                    x: (innerMovieRect.width - fullRect.width) / 2
                    anchors.bottom: innerMovieRect.bottom
                    Text{
                        id: nameText
                        width: 100
                        height: 30
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: name

                    }
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
                }
            }
        }
    }

    Rectangle{
        id: loadingRect
        width: parent.width
        height: 30
        color: "transparent"
        anchors.bottom: movieOuterRect.bottom

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
        Ajax.get("https://ljxwtl.cn/kuwo/mvList/236682871/1/30",function(response,data){
            console.log(JSON.stringify(data.data.mvlist))

            let movieList = data.data.mvlist;
            console.log(movieList.length)
            for (let i=0;i<movieList.length;i++){
                movieListModel.append(movieList[i]);
            }

            loadingImage.visible = false;
        },function(){});
    }
}

