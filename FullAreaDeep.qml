import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14
Rectangle{
    id: fullAreaRect
    width: window.width
    height: window.height

    border.width: 3
    border.color: "#CCCCCC"

    property string backgroundImageSource: "qrc:/images/resources/images/background.jpg"

    color: "transparent"

    Image{
        id: backgroundImage
        source: backgroundImageSource
        height: fullAreaRect.height
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        id: mouseArea
        property int mouseX: 0
        property int mouseY: 0
        property bool pressedFlag: false
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: true

        onPressed: {
            mouseX = mouse.x;
            mouseY = mouse.y;
            pressedFlag = true;
        }

        onReleased: {
            pressedFlag = false;
        }

        onPositionChanged: {
            if (pressedFlag){
                //鼠标偏移量
                let delta = Qt.point(mouse.x - mouseX, mouse.y - mouseY);
                //如果window继承自QWidget,用setPos
                window.setX(window.x + delta.x);
                window.setY(window.y + delta.y);
            }
        }
    }
}
