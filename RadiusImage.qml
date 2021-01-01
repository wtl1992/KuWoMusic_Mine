import QtQuick 2.14
import QtGraphicalEffects 1.0
Item {
    id: hotMusicItem

    property int imageWidth
    property int imageHeight
    property var anchorsTop: personRecommendTmpRect.bottom
    property var anchorsLeft: personRecommendRect.left
    property int leftMargin: 10
    property int topMargin: 10
    property string imageSource
    property int imageRasdius: 5

    width: imageWidth
    height: imageHeight

    anchors.top: anchorsTop
    anchors.left: anchorsLeft
    anchors.leftMargin: leftMargin
    anchors.topMargin: topMargin
    Image {
        id: hotMusicImage
        smooth: true
        visible: false
        anchors.fill: parent
        source: imageSource
        sourceSize: Qt.size(imageWidth,imageHeight)
        antialiasing: true
    }
    Rectangle {
        id: hotMusicRect
        color: "black"
        anchors.fill: parent
        radius: imageRasdius
        visible: false
        antialiasing: true
        smooth: true
    }
    OpacityMask {
        id: hotMusicOpcityMask
        anchors.fill: hotMusicImage
        source: hotMusicImage
        maskSource: hotMusicRect
        visible: true
        antialiasing: true
    }
}
