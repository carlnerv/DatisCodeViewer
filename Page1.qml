import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQml 2.2

Item {
    id: pageDatis

    GridLayout {
        id: layout
        rows: 2
        columns: 2
        anchors.margins: 5

        anchors.fill: parent

//        columnSpacing: 2
//        rowSpacing: 2
        flow: GridLayout.TopToBottom

        Rectangle {
            id: datisCodeRect
            // 使用Layout布局则使用Layout宽高，另有最大最小宽高
            Layout.preferredHeight: parent.height * 0.6
            Layout.preferredWidth: parent.width * 0.6
            border.width: 1
            border.color: "grey"


            Text {
                id: datisCodeText
                color: "#07b716"
                font.family: "Arial"
                font.bold: true
//                font.pointSize: 72
                font.pointSize: parent.height/2
                anchors.centerIn: parent
                text: qsTr("A")

            }

            Text {
                //                id: datisCodeRectText
                text: qsTr("通播代号")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }
        }

        Rectangle {
            id: rwyRect
            // 相对高度
            Layout.preferredHeight: parent.height - datisCodeRect.height - parent.columnSpacing
            Layout.preferredWidth: datisCodeRect.width
            border.width: 1
            border.color: "grey"

            Text {
                id: rwyText
                color: "#07b716"
                font.family: "Arial"
                font.bold: true
//                font.pointSize: 72
                font.pointSize: parent.height/2
                anchors.centerIn: parent
                text: qsTr("08")
            }



            Text {
                //                id: datisCodeRectText
                text: qsTr("跑道号")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }
        }

        ColumnLayout {
            Rectangle {
                id: datisTimeRect
    //            width: 200
    //            height: 200
    //            color: "#ffffff"
                // 左边控件定义了宽度，这里填满剩下的宽度
                Layout.fillHeight: true
                // 左边控件定义了高度，这里为左边控件的高度
                Layout.fillWidth: true
    //            Layout.rowSpan: 2
    //            Layout.columnSpan: 1
                border.width: 1
                border.color: "grey"

                Text {
                    //                id: datisCodeRectText
                    text: qsTr("更新时间")
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 2
                }

                Text {
                    id: datisTime
                    anchors.centerIn: parent
                    text: qsTr("text")
                    font.pointSize: parent.height/8
                }
            }

            Rectangle {
                id: datisOverTimeRect
    //            width: 200
    //            height: 200
    //            color: "#ffffff"
                // 左边控件定义了宽度，这里填满剩下的宽度
                Layout.fillHeight: true
                // 左边控件定义了高度，这里为左边控件的高度
                Layout.fillWidth: true
    //            Layout.rowSpan: 2
    //            Layout.columnSpan: 1
                border.width: 1
                border.color: "grey"

                Text {
                    //                id: datisCodeRectText
                    text: qsTr("超时时间")
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.top: parent.top
                    anchors.topMargin: 2
                }

                Text {
                    id: datisOverTime
                    anchors.centerIn: parent
                    text: qsTr("text")
                    font.pointSize: parent.height/8
                }
            }

        }



        Rectangle {
            id: timeRect
//            width: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
//            Layout.rowSpan: 2
//            Layout.columnSpan: 1
//            color: "#ffffff"
            border.width: 1
            border.color: "grey"
            Text {
                //                id: datisCodeRectText
                text: qsTr("当前时间")
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 2
            }
            Text {
                id: currentTime
//                font.pointSize: 24
                font.pointSize: parent.height/8
                font.family: "Arial"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("text")
                anchors.centerIn: parent

            }
            Timer {
                interval: 500; running: true; repeat: true;
                onTriggered: currentTime.text = Qt.formatDate(new Date(), "yyyy-MM-dd") + "\n" + Qt.formatTime(new Date(), "hh:mm:ss");
                triggeredOnStart: true
//                onTriggered: currentTime.text = Date().toString();
            }
        }
    }






}
