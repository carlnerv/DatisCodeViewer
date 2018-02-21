import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

Item {
    anchors.fill: parent
    property alias tabBarIndex: tabBar.currentIndex
    //    property alias localFileSource: fileDialog.fileUrl
    //    property alias ftpFileSource: ftpPath.text

    ScrollView {
        focusPolicy: Qt.WheelFocus
        //        contentWidth: 200
        //        anchors.fill: parent

        ColumnLayout {
            id: popupCl
            anchors.fill: parent

            TabBar {
                id: tabBar
                spacing: 1
                Layout.fillWidth: true
                anchors.top: parent.top
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
                height: 150
                //        currentIndex: 0
                currentIndex: tabBar.currentIndex
                //                    width: parent.width
                anchors.top: tabBar.bottom
                anchors.topMargin: 5

                // ftp信息
                ColumnLayout {
                    id: ftpInfo
                    //            spacing: 5
                    Layout.fillWidth: true
                    TextField {
                        id: ftpPath
                        Layout.fillWidth: true
                        placeholderText: "FTP路径"
                        //                width: popupCl.width
                        onEditingFinished: {
                            page1BusyIndicator.running = true;
                            conf.sourceUrl = Qt.resolvedUrl(text);
                            console.log(conf.sourceUrl.toString());
                            console.log(conf.sourceUrl == Qt.resolvedUrl(text));
                        }
                    }
                    //            Rectangle {
                    //                height: 80
                    Text {
                        text: "Datis输出文件所在的FTP路径<br>eg. ftp://[user[:password]@]hostname/path/"
                    }
                    //            }
                }

                // 本地文件
                Item {
                    id: item1
                    height: ftpInfo.height
                    Button {
                        id: openFileButton
                        Text {
                            id: openFileButtonText
                            anchors.fill: parent
                            text: "打开本地文件"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideMiddle

                        }
                        width:  parent.width
                        height: 40
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            //                    fileDialog.
                            fileDialog.open();
                            page1BusyIndicator.running = true;
                        }
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
                rows: 4
                columns: 2

                Text {
//                    id: text1
                    text: qsTr("通播代号字体大小")
                    font.pixelSize: 12
                }

                SpinBox {
                    id: spinBox_datis_ver_fontsize
                    width: 100
                    height: 20
                }

                Text {
//                    id: text1
                    text: qsTr("跑到号号字体大小")
                    font.pixelSize: 12
                }

                SpinBox {
                    id: spinBox_runway_fontsize
                    width: 100
                    height: 20
                }

                Text {
//                    id: text1
                    text: qsTr("通播内容字体大小")
                    font.pixelSize: 12
                }

                SpinBox {
                    id: spinBox_datis_text_fontsize
                    width: 100
                    height: 20
                }

                Text {
//                    id: text1
                    text: qsTr("刷新时间")
                    font.pixelSize: 12
                }

                SpinBox {
                    id: spinBox_refresh_interval
                    width: 100
                    height: 20
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
    } // ScrollView

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

    Connections {
        target: rootWindow
        Component.onCompleted: {
            if(conf.loadConf()) {
                //                xmlModel.source = conf.xmlSourceUri
                tabBar.setCurrentIndex(conf.tabIndex)
                switch (conf.tabIndex){
                case 0:
                    //                    ftpPath.text = conf.xmlSourceUri
                    ftpPath.text = conf.sourceUrl.toString()
                    break;
                case 1:
                    //                    openFileButtonText.text = conf.xmlSourceUri
                    openFileButtonText.text = conf.sourceUrl.toString().slice(8)
                    break;
                }
                //                    confReloadTimer.start();
                getData();
            }
        }
    }

}



