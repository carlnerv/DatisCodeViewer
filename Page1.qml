import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQml 2.2

Item {
    anchors.fill: parent
    property var locale: Qt.locale()

    GridLayout {
//        id: layout
        rows: 2
        columns: 2
        anchors.margins: 5
        anchors.fill: parent
        flow: GridLayout.TopToBottom

        // 通播版本号
        Rectangle {
//            id: datisCodeRect
            // 使用Layout布局则使用Layout宽高，另有最大最小宽高
//            Layout.preferredHeight: parent.height * 0.3
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.minimumWidth: 100
//            implicitHeight: 100
//            implicitWidth: 100
            border.width: 1
            border.color: "grey"
            color: "transparent"
            Layout.preferredHeight: parent.height * 0.3

            Text {
                id: tATISVersion
//                color: "#07b716"
                font.family: "Arial"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                padding: 10
                fontSizeMode: Text.Fit
                anchors.fill: parent
                text: qsTr("-")
                font.pointSize: 120
            }

            Text {
                text: qsTr("通播代号")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }


        } // 通播版本号

        // 跑道号
        Rectangle {
//            id: rwyRect
            // 相对高度
//            Layout.preferredHeight: parent.height - datisCodeRect.height - parent.columnSpacing
//            Layout.preferredWidth: datisCodeRect.width
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.minimumWidth: 100
            border.width: 1
            border.color: "grey"
            color: "transparent"
            Layout.preferredHeight: parent.height * 0.3

            Text {
                id: tArrRwy
                color: "green"
                text: qsTr("-")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Arial"
                font.bold: true
                padding: 10
                fontSizeMode: Text.Fit
                font.pointSize: 120
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
            }

            Text {
                text: qsTr("跑道号")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }
        } // 跑道号

        // GridLayout 2

        // 当前时间
//        Rectangle {
////            id: timeRect
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            Layout.minimumHeight: 100
//            Layout.minimumWidth: 100
//            border.width: 1
//            border.color: "grey"
//            color: "transparent"
//            Text {
//                text: qsTr("当前时间")
//                anchors.left: parent.left
//                anchors.leftMargin: 6
//                anchors.top: parent.top
//                anchors.topMargin: 2
//            }
//            Text {
//                id: currentTime
//                font.pointSize: 120
//                font.family: "Arial"
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                text: qsTr("text")
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.fill: parent
//                padding: 10
//                fontSizeMode: Text.Fit

//            }



//        }

        // GridLayout 3

        Rectangle {
            Layout.rowSpan: 2
//            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
//            Layout.minimumWidth: 100
            Layout.preferredWidth: parent.width * 0.66

            border.color: "grey"
            border.width: 1

            Text {
                text: qsTr("通播内容")
//                Layout.preferredWidth: parent.width * 0.3
//                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }

            Text {
                id: tDatisText
                text: qsTr("-")
//                Layout.preferredWidth: 0
//                Layout.fillWidth: true
//                Layout.preferredHeight: implicitHeight * 3
//                text: qsTr("-")
                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
                horizontalAlignment: Text.AlignLeft
//                font.family: "Arial"
//                font.bold: true
                padding: 10
                fontSizeMode: Text.Fit
                font.pointSize: 32
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
                anchors.margins: 10
                wrapMode: Text.WordWrap
            }

//            GridLayout {
//                anchors.fill: parent
////                anchors.margins: 5

//                rowSpacing: 2
//                columns: 2

//                // row0
//                Text {
//                    text: "更新时间"
//                    Layout.preferredWidth: parent.width * 0.3
//                    horizontalAlignment: Text.AlignHCenter
//                }

//                Text {
//                    id: tUpdateTime
//                    text: qsTr("-")
//                    Layout.fillWidth: true
//    //                verticalAlignment: Text.AlignVCenter
//    //                horizontalAlignment: Text.AlignHCenter
//    //                anchors.horizontalCenter: parent.horizontalCenter
//    //                anchors.fill: parent
//    //                font.family: "Arial"
////                    padding: 10
//    //                fontSizeMode: Text.Fit
//    //                font.pointSize: 120
//                }

//                // row1
//                Text {
//                    text: qsTr("超时时间")
//                    Layout.preferredWidth: parent.width * 0.3
//                    horizontalAlignment: Text.AlignHCenter
//                }

//                Text {
//                    id: tExpiredTime
//                    text: qsTr("-")
//                    Layout.fillWidth: true
//                }

//                // row2
//                // row3

//                // row4

//                // row5

//                // row6

//                // row7

//                // row8

//            }


        }



    }

    // 定时器，0.5s，刷新时间
//    Timer {
//        interval: 500; running: true; repeat: true;
//        onTriggered: {
//            var date = new Date();
//            currentTime.text = Qt.formatDate(date, "yyyy-MM-dd") + "\n" + Qt.formatTime(date, "hh:mm:ss");
//            var datisExpiredTime = Date.fromLocaleString(locale, tExpiredTime.text, "yyyy-MM-dd hh:mm:ss");
////                    console.log(datisExpiredTime)
//            if(date > datisExpiredTime){
//                tATISVersion.color = "red"
//            }
//            else {
//                tATISVersion.color = "green"
//            }
//        }
//        triggeredOnStart: true
//    }

    function loadDatisMessage() {
//        tATISVersion.text = xmlModel.get(0).ATISVersion;
//        tArrRwy.text = xmlModel.get(0).ArrRwy;
//        tUpdateTime.text = xmlModel.get(0).UpdateTime;
//        tExpiredTime.text = xmlModel.get(0).ExpiredTime;
//        tFreeText.text = xmlModel.get(0).tagUP + "\n" + xmlModel.get(0).tagCH + "\n" + xmlModel.get(0).tagEN;

        tATISVersion.text = conf.datisVer;
        tArrRwy.text = conf.runway;
        tDatisText.text = conf.datisText;

    }



}
