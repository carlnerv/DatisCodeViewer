import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls.impl 2.1
//import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
//import QtQml 2.2
//import QtQml.Models 2.2
import QtQuick.XmlListModel 2.0
import QtGraphicalEffects 1.0

import com.mycompany.conf 1.0
//import com.mycompany.ftpmanager 1.0

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
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: -3
                color: "#80000000"

            }
        }

        PopupPage {
            id: popPage
        }

        onClosed: {
//            if(xmlModel.status == XmlListModel.Ready) {
//                conf.xmlSourceUri = xmlModel.source
//                conf.tabIndex = popPage.tabBarIndex
//                conf.saveConf()
//            }
//            conf.textSourceUri =
//            if (conf.readDatisText()) {
//                page1.loadDatisMessage();
//                page1BusyIndicator.running = false;
//                confReloadTimer.start();
//            }
            confReloadTimer.start();
            conf.tabIndex = popPage.tabBarIndex;
            conf.saveConf();
        }


    } // popup

//    XmlListModel {
//        id: xmlModel
//        // source:
//        query: "/ACARS/Body"


//        onStatusChanged: {
//            if(status == XmlListModel.Ready) {
//                page1.loadDatisMessage();
//                page1BusyIndicator.running = false;
//                xmlReloadTimer.start();
//            }
//        }
//    }

    Timer {
        id: confReloadTimer
//        repeat: true
        onTriggered: {
//            xmlModel.reload();
//            conf.readDatisText();
//            mFtp.
            switch (conf.tabIndex){
            case 0:     // ftp file
//                    ftpPath.text = conf.xmlSourceUri
//                ftpPath.text = conf.textSourceUri
//                if ();

                break;
            case 1:     // local file
//                    openFileButtonText.text = conf.xmlSourceUri
//                openFileButtonText.text = conf.textSourceUri
//                break;
                if (Conf.readLocalFile()){
    //                conf.readDatisText();
                    page1.loadDatisMessage();
                    page1BusyIndicator.running = false;
    //                confReloadTimer.start();
                } else {
    //                running = false;
                    page1BusyIndicator.running = true;
    //                repeat = false;
                }
            }

            restart();

        }
    }

    Conf {
        id: conf
    }

//    FtpManager {

//    }

}
