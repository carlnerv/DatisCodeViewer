import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls.impl 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: popupCl
    anchors.fill: parent

//    property alias stackIndex: stackLayout.currentIndex
//    property alias tabBarIndex: tabBar.currentIndex
    property alias ftpSource: ftpPath.text
    property alias localFileSource: openFileButton.text

    TabBar {
        id: tabBar
        spacing: 1
        Layout.fillWidth: true
        currentIndex: stackLayout.currentIndex
        background: Rectangle {
            color: "#eeeeee"
        }

        TabButton {
            id: tabButton1
            text: "FTP"
            // 使用Default需要import QtQuick.Controls.impl 2.1
            // 查看QtQuick.Controls中的TabButton
            // 未选中的TabButton颜色是tabButtonColor
            background: Rectangle {
                    implicitHeight: 40
                    color: tabButton1.down
                        ? (tabButton1.checked ? Default.tabButtonCheckedPressedColor : Default.tabButtonPressedColor)
                        : (tabButton1.checked ? "transparent" : /*Default.tabButtonColor*/"grey")
                }
//            onClicked: {
//                openFileButton.text = "打开本地文件"
//            }
        }
        TabButton {
            id: tabButton2
            text: "本地文件"
            background: Rectangle {
                    implicitHeight: 40
                    color: tabButton2.down
                        ? (tabButton2.checked ? Default.tabButtonCheckedPressedColor : Default.tabButtonPressedColor)
                        : (tabButton2.checked ? "transparent" : /*Default.tabButtonColor*/"grey")
                }
//            onClicked: {
//                ftpPath.text = ""
//                ftpUser.text = ""
//                ftpPW.text = ""
//            }
        }
    }

    StackLayout {
        id: stackLayout
        height: 150
        currentIndex: tabBar.currentIndex
//                    width: parent.width

        // ftp信息
        ColumnLayout {
            id: ftpInfo
//            spacing: 5
            TextField {
                id: ftpPath
                placeholderText: "FTP路径"
                width: popupCl.width
            }
            Rectangle {
                height: 20
                Text {
                    text: "Message.xml所在的FTP路径<br>eg. 172.187.17.106/DATIS/Data"
                }
            }


            TextField {
                id: ftpUser
                placeholderText: "用户名"
                width: popupCl.width
            }
            TextField {
                id: ftpPW
                placeholderText: "密码"
                echoMode: "Password"
                width: popupCl.width
            }
            Button {
                text: "载入"
                onClicked: {
                    page1BusyIndicator.running = true;
                    var str = "ftp://"
                    //  ftp://user:password@host:port/path
//                    if(ftpPath.text.slice(0,8)!="ftp://" )
                    if(ftpUser.text.length) {
                        str = "ftp://" + ftpUser.text + ":" + ftpPW.text + "@" + ftpPath.text + "Message.xml";
                    }
                    else {
                        str = "ftp://" + ftpPath.text + "/Message.xml";
                    }
//                    text = "载入"
                    xmlModel.source = str;
//                    console.log(str)
//                    xmlModel.reload();
//                    console.log("ftpUser ", ftpUser.text, "ftpPW", ftpPW.text)
                }
            }

        }

        // 本地文件
        Item {
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
                onClicked: {
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

    Rectangle {
        Layout.fillWidth:  true
        Layout.minimumHeight: 200
        Layout.fillHeight: true
        Text {
            anchors.fill: parent
            fontSizeMode: Text.Fit
            text: "<h1>关于Datis Code Viewer</h1><br><p><b>Version 1.0</b><br>
使用 Qt 5.8</p>
<p>Copyright © 2017 carlnerv</p>
<p>License: <a href=''>MIT License</a><br>
Project Hosted at <a href='https://github.com/carlnerv/DatisCodeViewer'>GitHub</a></p>"
            onLinkActivated: Qt.openUrlExternally("https://github.com/carlnerv/DatisCodeViewer")
        }
    }

    FileDialog {
        id: fileDialog
        title: "打开Message.xml文件"
        nameFilters: [ "Message文件 (Message.xml)" ]
        onAccepted: {
            var furl = String(fileUrl);
            openFileButtonText.text = furl.slice(8); // 切掉file://，从第8个字符开始
            xmlModel.source = fileUrl;
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
                xmlModel.source = conf.xmlSourceUri
    //            popPage.stackIndex = conf.tabIndex
    //            popPage.tabBarIndex = conf.tabIndex
                tabBar.setCurrentIndex(conf.tabIndex)
                switch (conf.tabIndex){
                case 0:
//                    popPage.ftpSource = conf.xmlSourceUri
                    ftpPath.text = conf.xmlSourceUri

                    break;
                case 1:
//                    popPage.localFileSource = conf.xmlSourceUri
                    openFileButton.text = conf.xmlSourceUri
    //                break;
                }
            }
        }
    }

} // columnLayout




