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

ApplicationWindow {
    id: rootWindow
    visible: true
    visibility: "Maximized"
    width: 800
    height: 600
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


    } // popup

    XmlListModel {
        id: xmlModel
        // source:
        query: "/ACARS/Body"
        XmlRole { name:"ATISVersion"; query:"@ATISVersion/string()" }
        XmlRole { name:"UpdateTime"; query: "@UpdateTime/string()" }
        XmlRole { name:"ExpiredTime"; query: "@ExpiredTime/string()" }
        XmlRole { name:"DepRwy"; query:"Receiver/nd[2]/@DepRwy/number()" }
        XmlRole { name:"ArrRwy"; query:"Receiver/nd[2]/@ArrRwy/number()" }
        XmlRole { name:"approach"; query:"Receiver/nd[8]/@type/string()" }

        onStatusChanged: {
            if(status == XmlListModel.Ready) {
                page1.loadDatisMessage();
                page1BusyIndicator.running = false;
                xmlReloadTimer.start();
            }
        }
    }

    Timer {
        id: xmlReloadTimer
//        repeat: true
//        triggeredOnStart: true
        onTriggered: {
            xmlModel.reload();
        }
    }

}
