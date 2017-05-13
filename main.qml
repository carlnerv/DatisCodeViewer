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
            if(xmlModel.status == XmlListModel.Ready) {
                conf.xmlSourceUri = xmlModel.source
                conf.tabIndex = popPage.tabBarIndex
                conf.saveConf()
            }
        }


    } // popup

    XmlListModel {
        id: xmlModel
        // source:
        query: "/ACARS/Body"
        XmlRole { name:"ATISVersion"; query:"@ATISVersion/string()" }
        XmlRole { name:"UpdateTime"; query: "@UpdateTime/string()" }
        XmlRole { name:"ExpiredTime"; query: "@ExpiredTime/string()" }
        // Transition
        XmlRole { name:"TransitionLevel"; query: "Receiver/nd[1]/@TransitionLevel/number()" }
        XmlRole { name:"AltitudeUnit"; query:"Receiver/nd[1]/@AltitudeUnit/string()" }
        XmlRole { name:"TransitionAltitude"; query:"Receiver/nd[1]/@TransitionAltitude/number()" }
        // Rwy
        XmlRole { name:"DepRwy"; query:"Receiver/nd[2]/@DepRwy/number()" }
        XmlRole { name:"ArrRwy"; query:"Receiver/nd[2]/@ArrRwy/number()" }
        // Type
        XmlRole { name:"SMI"; query:"Receiver/nd[3]/@SMI/string()" }
        XmlRole { name:"TransmitType"; query:"Receiver/nd[3]/@TransmitType/string()" }
        // Identify
        XmlRole { name:"AUTO"; query:"Receiver/nd[4]/@AUTO/string()" }
        XmlRole { name:"UTCTime"; query:"Receiver/nd[4]/@UTCTime/string()" }
        XmlRole { name:"SKC"; query:"Receiver/nd[4]/@SKC/string()" }
        XmlRole { name:"CAVOK"; query:"Receiver/nd[4]/@CAVOK/string()" }
        XmlRole { name:"NSC"; query:"Receiver/nd[4]/@NSC/string()" }
        XmlRole { name:"NCD"; query:"Receiver/nd[4]/@NCD/string()" }
        // HorizontalVisibility
        XmlRole { name:"HorizontalVisibilityMax"; query:"Receiver/nd[5]/@HorizontalVisibilityMax/number()" }
        XmlRole { name:"HorizontalVisibilityMin"; query:"Receiver/nd[5]/@HorizontalVisibilityMin/number()" }
        XmlRole { name:"HorizontalDirectionMin"; query:"Receiver/nd[5]/@HorizontalDirectionMin/number()" }
        XmlRole { name:"HorizontalDirectionMax"; query:"Receiver/nd[5]/@HorizontalDirectionMax/number()" }
        // AirDewTemperture +1/1 -1/M1
        XmlRole { name:"DewTemperture"; query:"Receiver/nd[6]/@DewTemperture/string()" }
        XmlRole { name:"AirTemperture"; query:"Receiver/nd[6]/@AirTemperture/string()" }
        // Pressure
        XmlRole { name:"QNHValue"; query:"Receiver/nd[7]/@QNHValue/number()" }
        XmlRole { name:"PressureUnitage"; query:"Receiver/nd[7]/@PressureUnitage/string()" }
        // approach
        XmlRole { name:"approach"; query:"Receiver/nd[8]/@type/string()" }
        // Wind
        XmlRole { name:"WindUnitage"; query:"Sender/nd[1]/@WindUnitage/string()" }
        XmlRole { name:"Direction"; query:"Sender/nd[1]/@Direction/string()" }
        XmlRole { name:"GustySpeed"; query:"Sender/nd[1]/@GustySpeed/string()" }
        XmlRole { name:"Speed"; query:"Sender/nd[1]/@Speed/string()" }
        XmlRole { name:"DirectionMax"; query:"Sender/nd[1]/@DirectionMax/string()" }
        XmlRole { name:"DirectionMin"; query:"Sender/nd[1]/@DirectionMin/string()" }
        // Supplement
        XmlRole { name:"Description"; query:"Receiver/nd[2]/@SMI/string()" }
        XmlRole { name:"Precipitation"; query:"Receiver/nd[2]/@SMI/string()" }
        XmlRole { name:"RwyWindShear"; query:"Receiver/nd[2]/@SMI/string()" }
        XmlRole { name:"Phenomena"; query:"Receiver/nd[2]/@SMI/string()" }
        XmlRole { name:"Intension"; query:"Receiver/nd[2]/@SMI/string()" }
        // Runway_1
        XmlRole { name:"r1RunwayVisibility"; query:"Type/nd[1]/@RunwayVisibility/string()" }
        XmlRole { name:"r1RunwaySurface"; query:"Type/nd[1]/@RunwaySurface/string()" }
        XmlRole { name:"r1RunwayBrake"; query:"Type/nd[1]/@RunwayBrake/string()" }
        XmlRole { name:"r1QFEValue"; query:"Type/nd[1]/@QFEValue/string()" }
        XmlRole { name:"r1RunwayVisibilityMax"; query:"Type/nd[1]/@RunwayVisibilityMax/string()" }
        XmlRole { name:"r1RunwayTrend"; query:"Type/nd[1]/@RunwayTrend/string()" }
        XmlRole { name:"r1Use"; query:"Type/nd[1]/@Use/string()" }
        XmlRole { name:"r1RwyNum"; query:"Type/nd[1]/@RwyNum/string()" }
        // Runway_2
        XmlRole { name:"r2RunwayVisibility"; query:"Type/nd[2]/@RunwayVisibility/string()" }
        XmlRole { name:"r2RunwaySurface"; query:"Type/nd[2]/@RunwaySurface/string()" }
        XmlRole { name:"r2RunwayBrake"; query:"Type/nd[2]/@RunwayBrake/string()" }
        XmlRole { name:"r2QFEValue"; query:"Type/nd[2]/@QFEValue/string()" }
        XmlRole { name:"r2RunwayVisibilityMax"; query:"Type/nd[2]/@RunwayVisibilityMax/string()" }
        XmlRole { name:"r2RunwayTrend"; query:"Type/nd[2]/@RunwayTrend/string()" }
        XmlRole { name:"r2Use"; query:"Type/nd[2]/@Use/string()" }
        XmlRole { name:"r2RwyNum"; query:"Type/nd[2]/@RwyNum/string()" }
        //
        XmlRole { name:"WeatherNum"; query:"Receiver/nd[5]/@SMI/string()" }
        // CloudVertical
        XmlRole { name:"VerticalUnitage"; query:"Value/@VerticalUnitage/string()" }
        XmlRole { name:"CloudNum"; query:"Value/@CloudNum/string()" }
        XmlRole { name:"Vertical"; query:"Value/@Vertical/string()" }
        // CloudVertical_1
        XmlRole { name:"CloudHeight"; query:"Value/nd[1]/@CloudHeight/string()" }
        XmlRole { name:"CloudAmount"; query:"Value/nd[1]/@CloudAmount/string()" }
        XmlRole { name:"CloudUnitage"; query:"Value/nd[1]/@CloudUnitage/string()" }
        XmlRole { name:"CloudFigure"; query:"Value/nd[1]/@CloudFigure/string()" }
        // tag Freetxt
        XmlRole { name:"tagUP"; query:"Tag/nd[1]/@UP/string()" }
        XmlRole { name:"tagCH"; query:"Tag/nd[1]/@CH/string()" }
        XmlRole { name:"tagEN"; query:"Tag/nd[1]/@EN/string()" }

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

//    Component.onCompleted: {
//        if(conf.loadConf()) {
//            xmlModel.source = conf.xmlSourceUri
////            popPage.stackIndex = conf.tabIndex
////            popPage.tabBarIndex = conf.tabIndex
//            switch (conf.tabIndex){
//            case 0:
//                popPage.ftpSource = conf.xmlSourceUri
//                break;
//            case 1:
//                popPage.localFileSource = conf.xmlSourceUri
////                break;
//            }
//        }
//    }

}
