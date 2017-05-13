import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQml 2.2

Item {
    anchors.fill: parent
    property var locale: Qt.locale()

    GridLayout {
        id: layout
        rows: 3
//        columns: 3
        anchors.margins: 5
        anchors.fill: parent
        flow: GridLayout.TopToBottom

        // 通播版本号
        Rectangle {
            id: datisCodeRect
            // 使用Layout布局则使用Layout宽高，另有最大最小宽高
//            Layout.preferredHeight: parent.height * 0.3
//            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.minimumWidth: 100
//            implicitHeight: 100
//            implicitWidth: 100
            border.width: 1
            border.color: "grey"
            color: "transparent"

            Text {
                id: datisCodeText
//                color: "#07b716"
                font.family: "Arial"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                padding: 10
                fontSizeMode: Text.VerticalFit
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
            id: rwyRect
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

            Text {
                id: rwyText
                color: "green"
                text: qsTr("-")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Arial"
                font.bold: true
                padding: 10
                fontSizeMode: Text.VerticalFit
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
        Rectangle {
            id: timeRect
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.minimumWidth: 100
            border.width: 1
            border.color: "grey"
            color: "transparent"
            Text {
                text: qsTr("当前时间")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }
            Text {
                id: currentTime
                font.pointSize: 120
                font.family: "Arial"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("text")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.fill: parent
                padding: 10
                fontSizeMode: Text.Fit

            }

            // 定时器，0.5s，刷新时间
            Timer {
                interval: 500; running: true; repeat: true;
                onTriggered: {
                    var date = new Date();
                    currentTime.text = Qt.formatDate(date, "yyyy-MM-dd") + "\n" + Qt.formatTime(date, "hh:mm:ss");
                    var datisExpiredTime = Date.fromLocaleString(locale, datisOverTime.text, "yyyy-MM-dd hh:mm:ss");
//                    console.log(datisExpiredTime)
                    if(date > datisExpiredTime){
                        datisCodeText.color = "red"
                    }
                    else {
                        datisCodeText.color = "green"
                    }
                }
                triggeredOnStart: true
            }

        }

        // GridLayout 3
        Rectangle {
            Layout.rowSpan: 3
//            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 100
//            Layout.minimumWidth: 100
            Layout.preferredWidth: parent.width * 0.66

            border.color: "grey"
            border.width: 1
            GridLayout {
                anchors.fill: parent
                anchors.margins: 5

                rowSpacing: 2
                columns: 2

                // row0
                Text {
                    text: "更新时间"
                }

                Text {
                    id: datisTime
                    text: qsTr("-")
    //                verticalAlignment: Text.AlignVCenter
    //                horizontalAlignment: Text.AlignHCenter
    //                anchors.horizontalCenter: parent.horizontalCenter
    //                anchors.fill: parent
    //                font.family: "Arial"
    //                padding: 10
    //                fontSizeMode: Text.Fit
    //                font.pointSize: 120
                }

                // row1
                Text {
                    text: qsTr("超时时间")
    //                anchors.left: parent.left
    //                anchors.leftMargin: 6
    //                anchors.top: parent.top
    //                anchors.topMargin: 2
                }

                Text {
                    id: datisOverTime
                    text: qsTr("-")
    //                anchors.horizontalCenter: parent.horizontalCenter
    //                anchors.fill: parent
//                    font.family: "Arial"
    //                verticalAlignment: Text.AlignVCenter
    //                horizontalAlignment: Text.AlignHCenter
    //                padding: 10
    //                fontSizeMode: Text.Fit
    //                font.pointSize: 120
                }

                // row2

                // row3

                // row4

                // row5

                // row6

                // row7

                // row8

            }

        }



    }



    function loadDatisMessage() {
        datisCodeText.text = xmlModel.get(0).ATISVersion;
        rwyText.text = xmlModel.get(0).ArrRwy;
        datisTime.text = xmlModel.get(0).UpdateTime;
        datisOverTime.text = xmlModel.get(0).ExpiredTime;
    }



}
