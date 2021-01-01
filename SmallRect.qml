import QtQuick 2.0

Rectangle{
    id: dirRect
    width: 100
    height: 30

    color: rectColorStr

    property string sourceImageStr
    property string textStr
    property var rightDownloadRect
    property var anchorsLeft
    property int anchorsLeftMargin: 5
    property string rectColorStr: "transparent"
    property bool isButtonShow: false

    function setTimeout(callback,timeout){
        let timer = Qt.createQmlObject("import QtQuick 2.14; Timer {}", window);
        timer.interval = timeout;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    }


    anchors.verticalCenter: rightDownloadRect.verticalCenter
    anchors.left: anchorsLeft
    anchors.leftMargin: anchorsLeftMargin
    Image{
        id: dirImage
        source: sourceImageStr
        width: 20
        fillMode: Image.PreserveAspectFit

        anchors.verticalCenter: dirRect.verticalCenter
        anchors.left: dirRect.left
        anchors.leftMargin: 5
    }

    Text{
        id: dirText

        text: textStr
        anchors.verticalCenter: dirRect.verticalCenter
        anchors.left: dirImage.right
        anchors.leftMargin: 5
    }


    PropertyAnimation {
        id: dirColorAnimation
        target: dirRect
        property: "color"
        from: "transparent"
        to: "#66000000"
        duration: 800
    }

    PropertyAnimation {
        id: dirReverseColorAnimation
        target: dirRect
        property: "color"
        from: "#66000000"
        to: "transparent"
        duration: 800
    }

    MouseArea{
        id: dirMouseArea
        anchors.fill: parent

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            dirColorAnimation.start();
            if (isButtonShow){
                setTimeout(function(){
                    dirRect.color = rectColorStr;
                },1000);
            }
        }

        onExited: {
            if (!isButtonShow){
                dirReverseColorAnimation.start();
            }
        }
    }
}
