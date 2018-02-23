import QtQuick 2.10
//import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: rootWindow
    visible: true
//    visibility: "Maximized"
    width: 1024
    height: 768
    title: qsTr("DATIS Code Viewer")

//    var intSec = 0;

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

    Item {
        id: page1
        anchors.fill: parent
        GridLayout {
            //        id: layout
            rows: 2
            rowSpacing: 5
            columns: 2
            columnSpacing: 5
            anchors.margins: 5
            anchors.fill: parent
            flow: GridLayout.TopToBottom

            // 通播版本号
            Rectangle {
                //            id: datisCodeRect
                // 使用Layout布局则使用Layout宽高，另有最大最小宽高
                Layout.preferredHeight: parent.height * 0.5
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

                Text {
                    id: tAtisVer
                    //                color: "#07b716"
                    font.family: "Arial"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    padding: 10
                    fontSizeMode: Text.Fit
                    anchors.fill: parent
                    text: qsTr("-")
//                    font.pointSize: 120
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
//                    font.pointSize: 120
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
            Rectangle {
                Layout.rowSpan: 2
                //            Layout.columnSpan: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumHeight: 100
                Layout.minimumWidth: 100
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
                    id: tAtisText
                    text: qsTr("-")
                    //                Layout.preferredWidth: 0
                    //                Layout.fillWidth: true
                    //                Layout.preferredHeight: implicitHeight * 3
                    //                text: qsTr("-")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.fill: parent
                    anchors.margins: 10
                    verticalAlignment: Text.AlignVCenter
                    //                horizontalAlignment: Text.AlignHCenter
                    horizontalAlignment: Text.AlignLeft
                    //                font.family: "Arial"
                    //                font.bold: true
                    padding: 10
                    fontSizeMode: Text.Fit
//                    font.pointSize: 32
                    wrapMode: Text.WordWrap
                }
            }
        }

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
    } // page1


    // 设置页面
    Popup {
        id: popup
        width: 300
        height: parent.height
        dim: true

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
//            id: popupBG
            border.color: "grey"
            border.width: 1
        }

//        Rectangle {
//            focusPolicy: Qt.WheelFocus
//            anchors.fill: parent

                ColumnLayout {
                    id: popupCl
                    anchors.fill: parent


                    TabBar {
                        id: tabBar
                        currentIndex: 0
                        spacing: 1
                        Layout.fillWidth: true
//                        anchors.top: parent.top
                        //        currentIndex: stackLayout.currentIndex
                        background: Rectangle {
                            color: "#eeeeee"
                            //            implicitHeight: 40
                            //            border.color: "grey"
                            //            border.width: 1
                            //            radius: 2
                        }

                        TabButton {
                            id: tabButton1
                            text: "FTP"
                            anchors.left: parent.left
                            // 使用Default需要import QtQuick.Controls.impl 2.1
                            // 查看QtQuick.Controls中的TabButton
                            // 未选中的TabButton颜色是tabButtonColor
                            //            background: Rectangle {
                            //                    implicitHeight: 40
                            //                    color: tabButton1.down
                            //                        ? (tabButton1.checked ? Default.tabButtonCheckedPressedColor : Default.tabButtonPressedColor)
                            //                        : (tabButton1.checked ? "transparent" : /*Default.tabButtonColor*/"grey")
                            //                }
                            background: Rectangle {
                                //                border.color: "grey"
                                //                border.width: 1
                                implicitHeight: 40
                                color: parent.down ? "silver" : (parent.checked ? "transparent" : "grey")
                                //                radius: 20
                            }


                        }
                        TabButton {
                            id: tabButton2
                            text: "本地文件"
                            anchors.left: tabButton1.right
                            //            background: Rectangle {
                            //                    implicitHeight: 40
                            //                    color: tabButton2.down
                            //                        ? (tabButton2.checked ? Default.tabButtonCheckedPressedColor : Default.tabButtonPressedColor)
                            //                        : (tabButton2.checked ? "transparent" : /*Default.tabButtonColor*/"grey")
                            //                }
                            background: Rectangle {
                                //                border.color: "grey"
                                //                border.width: 1
                                implicitHeight: 40
                                color: parent.down ? "silver" : (parent.checked ? "transparent" : "grey")
                                //                radius: 20
                            }
                        }
                    }   //TabBar

                    StackLayout {
                        id: stackLayout
//                        height: 150
                        Layout.preferredHeight: 100
                        //        currentIndex: 0
                        currentIndex: tabBar.currentIndex
                        //                    width: parent.width
                        anchors.top: tabBar.bottom
                        anchors.topMargin: 5

                        // ftp信息
                        ColumnLayout {
                            id: ftpInfo
//                            Layout.fillHeight: false
                            Layout.fillWidth: true
                            spacing: 5
                            TextField {
                                id: ftpPath
                                Layout.fillWidth: true
                                placeholderText: "FTP路径"
                                onEditingFinished: {
                                    page1BusyIndicator.running = true;
                                    conf.sourceUrl = Qt.resolvedUrl(text);
                                    console.log(conf.sourceUrl.toString());
                                    console.log(conf.sourceUrl == Qt.resolvedUrl(text));
                                }
                            }
                            Text {
                                text: "Datis输出文件所在的FTP路径<br>eg. ftp://[user[:password]@]hostname/path/"
                            }
                        }

                        // 本地文件

                        Button {
                            id: openFileButton
                            width:  parent.width
                            height: 40
//                            Layout.height: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Text {
                                id: openFileButtonText
                                anchors.fill: parent
                                text: "打开本地文件"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideMiddle
                            }
                            onClicked: {
                                //                    fileDialog.
                                fileDialog.open();
                                page1BusyIndicator.running = true;
                            }
                        }

                    } // StackLayout



                    Rectangle {
                        height: 2
                        Layout.fillWidth: true
                        color: "grey"
                    }

                    GridLayout {
                        id: gridLayout
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillWidth: true
                        //                width: 100
                        //                height: 100
//                        rows: 4
                        columns: 2

                        Text {
        //                    id: text1
                            text: qsTr("通播代号字体大小")
                            font.pixelSize: 12
                        }

                        SpinBox {
                            id: spinBox_datisVerFontSize
                            width: 100
                            height: 20
                            stepSize: 5
                            to: 200
                            value: tAtisVer.font.pointSize
                            onValueModified: {
                                tAtisVer.font.pointSize = value;
                            }
                        }

                        Text {
        //                    id: text1
                            text: qsTr("跑到号号字体大小")
                            font.pixelSize: 12
                        }

                        SpinBox {
                            id: spinBox_runwayFontSize
                            width: 100
                            height: 20
                            stepSize: 5
                            to: 200
                            value: tArrRwy.font.pointSize
                            onValueChanged: {
                                tArrRwy.font.pointSize = value;
                            }
                        }

                        Text {
        //                    id: text1
                            text: qsTr("通播内容字体大小")
                            font.pixelSize: 12
                        }

                        SpinBox {
                            id: spinBox_datisTextFontSize
                            width: 100
                            height: 20
                            to: 200
                            value: tAtisText.font.pointSize
                            onValueChanged: {
                                tAtisText.font.pointSize = value;
                            }
                        }

                        Text {
        //                    id: text1
                            text: qsTr("刷新时间（秒）")
                            font.pixelSize: 12
                        }

                        SpinBox {
                            id: spinBox_refreshInterval
                            width: 100
                            height: 20
                            from: 2
                            value: confReloadTimer.interval/1000
                            to: 300
                            onValueModified: {
                                confReloadTimer.interval = value*1000;
                            }
                        }
                    } // GridLayout

                    Rectangle {
                        height: 2
                        Layout.fillWidth: true
                        color: "grey"
                    }

                    Rectangle {
                        Layout.fillWidth:  true
                        Layout.minimumHeight: 200
                        Layout.fillHeight: true
                        Text {
                            anchors.fill: parent
                            fontSizeMode: Text.Fit
                            text: "<h1>关于Datis Code Viewer</h1><br><p><b>Version 1.0.2</b><br>
            使用 Qt 5.10</p>
            <p>Copyright © 2017 carlnerv</p>
            <p>License: <a href=''>MIT License</a><br>
            Project Hosted at <a href='https://github.com/carlnerv/DatisCodeViewer'>GitHub</a></p>"
                            onLinkActivated: Qt.openUrlExternally("https://github.com/carlnerv/DatisCodeViewer")
                        }
                    }



                } // columnLayout
//            } // ScrollView
//        }

        onClosed: {
            if (conf.sourceUrl.toString().length > 0) {
//                conf.tabIndex = popPage.tabBarIndex;
                conf.tabIndex = tabBar.currentIndex;
                conf.atisVerFontSize = tAtisVer.font.pointSize;
                conf.runwayFontSize = tArrRwy.font.pointSize;
                conf.atisTextFontSize = tAtisText.font.pointSize;
                conf.timerInterval = confReloadTimer.interval/1000;
//                conf.timerInterval = intSec;
                conf.saveConf();
    //            confReloadTimer.start();
                getData();
            }
        }


    } // popup

    Component.onCompleted: {
        if(conf.loadConf()) {
            //                xmlModel.source = conf.xmlSourceUri
            tabBar.setCurrentIndex(conf.tabIndex)
            switch (conf.tabIndex){
            case 0:
                //                    ftpPath.text = conf.xmlSourceUri
                ftpPath.text = conf.sourceUrl.toString();
                break;
            case 1:
                //                    openFileButtonText.text = conf.xmlSourceUri
                openFileButtonText.text = conf.sourceUrl.toString().slice(8);
                break;
            }
            //                    confReloadTimer.start();
            tAtisVer.font.pointSize = conf.atisVerFontSize;
            tArrRwy.font.pointSize = conf.runwayFontSize;
            tAtisText.font.pointSize = conf.atisTextFontSize;
//            intSec = conf.timerInterval;
            confReloadTimer.interval = conf.timerInterval*1000;
            getData();
        } else {
            tAtisVer.font.pointSize = 120;
            tArrRwy.font.pointSize = 120;
            tAtisText.font.pointSize = 32;
//            intSec = 5;
//            conf.timerInterval = 5;
            confReloadTimer.interval = 5000;
        }
    }

    FileDialog {
        id: fileDialog
        title: "打开datis目录"
        selectFolder: true
        onAccepted: {
            //                var furl = String(fileUrl);
            //            furl = furl.slice(8);
            //            furl += "/";
            //            openFileButtonText.text = furl.slice(8); // 切掉file://，从第8个字符开始
            openFileButtonText.text = fileUrl.toString().slice(8);
            //            xmlModel.source = fileUrl;
            //            conf.textSourceUri = fileUrl;
            //            conf.textSourceUri = furl.slice(8);
            conf.sourceUrl = fileUrl;
            console.log(fileUrl.toString());
            //            xmlReloadTimer.start();
            close();
        }
        onRejected: {
            close();
        }
    }

    Timer {
        id: confReloadTimer
//        repeat: true
//        triggeredOnStart: true

//        interval: conf.timerInterval*1000  // 5000ms
        onTriggered: {
            getData();
        }
    }

    Connections {
        target: downloadManager
        onDownloadCompleted: {
//            if (datisData.readFile(conf.sourceUrl)) {
//                page1.loadDatisMessage();
////                page1BusyIndicator.running = false;
//            } else {
//                page1BusyIndicator.running = true;
//            }
//            confReloadTimer.start();
            readData();
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
//            if (datisData.readFile(conf.sourceUrl)) {
//                page1.loadDatisMessage();
////                page1BusyIndicator.running = false;
//            } else {
//                page1BusyIndicator.running = true;
//            }
//            confReloadTimer.start();
            readData();
            break;
        }
    }

    function readData() {
        if (datisData.readFile(conf.sourceUrl)) {
            loadDatisMessage();
//                page1BusyIndicator.running = false;
        } else {
            page1BusyIndicator.running = true;
        }
        confReloadTimer.start();
    }

    function loadDatisMessage() {
//        tAtisVer.text = xmlModel.get(0).ATISVersion;
//        tArrRwy.text = xmlModel.get(0).ArrRwy;
//        tUpdateTime.text = xmlModel.get(0).UpdateTime;
//        tExpiredTime.text = xmlModel.get(0).ExpiredTime;
//        tFreeText.text = xmlModel.get(0).tagUP + "\n" + xmlModel.get(0).tagCH + "\n" + xmlModel.get(0).tagEN;

        tAtisVer.text = datisData.datisVer;
        tArrRwy.text = datisData.runway;
        tAtisText.text = datisData.datisText;
        var time = new Date();
        var expiredTime = new Date(new Date(datisData.datisTime).getTime() + 65*60000);
//        console.log(time);
//        var datisExpiredTime = Date.fromLocaleString(locale, tExpiredTime.text, "yyyy-MM-dd hh:mm:ss");
        //                    console.log(datisExpiredTime)
        if(time > expiredTime){
            tAtisVer.color = "red"
        }
        else {
            tAtisVer.color = "green"
        }

        page1BusyIndicator.running = false;

    }

}
