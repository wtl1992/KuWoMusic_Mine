import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

Window{
    id: skinWindow
    title: qsTr("皮肤盒子")

    width: 800
    height: 600

    modality: Qt.WindowModal


    ListModel{
        id: listModel
    }

    ScrollView{
        id: scrollView

        width: skinWindow.width
        height: skinWindow.height

        GridView{
            id: gridView

            width: parent.width

            cellWidth: 380
            cellHeight: 280

            anchors.left: scrollView.left
            anchors.leftMargin: 10

            model: listModel

            delegate: Rectangle{
                id: rect

                width: gridView.cellWidth
                height: gridView.cellHeight

                Image{
                    id: image
                    source: imageSource
                    width: rect.width
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        fullAreaLoader.item.backgroundImageSource = imageSource;
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        let backgroundImages = backgroundImagesReader.getBackgroundImages("resources/images/backgrounds");

        for (let i=0;i<backgroundImages.length;i++){
            listModel.append({"imageSource":backgroundImages[i]});
        }

        newWindowSetting.setWindowIcon(skinWindow,":/images/resources/images/skin.png");
    }
}
