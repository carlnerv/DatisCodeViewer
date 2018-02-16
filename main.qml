import QtQuick 2.10
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: rootWindow
    visible: true
//    visibility: "Maximized"
    width: 1024
    height: 768
    title: qsTr("DATIS Code Viewer")

    background: Rectangle {
        color: "#eeeeee"
    }

    header: ToolBar {
        ToolButton {
            anchors.right: parent.right
            Image {
                anchors.fill: parent
                source: "content/menu.png"
            }
            onClicked:  {
                popup.visible ? popup.close(): popup.open();
//                console.log(popPage.stackIndex,", ",popPage.tabBarIndex)
            }
        }
    }

    Page1 {
        id: page1
        Rectangle {
            anchors.fill: parent
            color: "grey"
            opacity: 0.3
            visible: page1BusyIndicator.running
        }
        BusyIndicator {
            id: page1BusyIndicator
            anchors.centerIn: parent
        }

    }


    // 设置页面
    Popup {
        id: popup
        width: 400
        height: parent.height

        enter: Transition {
            NumberAnimation {
                property: "x";
                from: rootWindow.width;
                to: rootWindow.width - popup.width
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "x"
                from: popup.x
                to: rootWindow.width
            }
        }

        background: Rectangle {
            id: popupBG
            border.color: "grey"
            border.width: 1
        }

        PopupPage {
            id: popPage
        }

        onClosed: {
            if (conf.sourceUrl.toString().length > 0) {
                conf.tabIndex = popPage.tabBarIndex;

                conf.saveConf();
    //            confReloadTimer.start();
                getData();
            }
        }


    } // popup

    Timer {
        id: confReloadTimer
//        repeat: true
//        triggeredOnStart: true
        interval: 5000
        onTriggered: {
            getData();
        }
    }

    Connections {
        target: downloadManager
        onDownloadCompleted: {
            if (datisData.readFile(conf.sourceUrl)) {
                page1.loadDatisMessage();
                page1BusyIndicator.running = false;
            } else {
                page1BusyIndicator.running = true;
            }
            confReloadTimer.start();
        }
    }


    function getData() {
        switch (conf.tabIndex){
        case 0:     // ftp file
//                    ftpPath.text = conf.xmlSourceUri
//                ftpPath.text = conf.textSourceUri
//                if ();
//            var url = Qt.resolvedUrl(conf.sourceUrl.toString() + "datis.ini");
//            downloadManager.doDownload(url);
//            url = Qt.resolvedUrl(conf.sourceUrl.toString() + "Voice.ini");
//            downloadManager.doDownload(url);

            downloadManager.doDownload(Qt.resolvedUrl(conf.sourceUrl.toString() + "datis.ini"));
            downloadManager.doDownload(Qt.resolvedUrl(conf.sourceUrl.toString() + "Voice.ini"));

            break;
        case 1:     // local file
            if (datisData.readFile(conf.sourceUrl)) {
                page1.loadDatisMessage();
                page1BusyIndicator.running = false;
                confReloadTimer.start();
            } else {
                page1BusyIndicator.running = true;
            }
            break;
        }
    }

}
