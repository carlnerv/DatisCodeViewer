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
//    property alias ftpSource: ftpPath.text
//    property alias localFileSource: fileDialog.fileUrl

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

                        var str = String(ftpPath.text);
                        if(str.slice(0,8)!="ftp://")str = "ftp://" + str;
                        xmlModel.source = str;


                    xmlModel.reload();
                }
            }

        }

        // 本地文件
//        Row {
//            spacing: 5
//            TextField {
//                id: localPath
//                placeholderText: "本地文件"
//                width: parent.width * 0.6
//            }
        Item {
            height: ftpInfo.height
            Button {
                id: openFileButton
                text: "打开本地文件"
                width:  parent.width
                height: 40
                onClicked: {
                    fileDialog.open();

                }
            }
//        }
        }
    } // StackLayout



    Rectangle {
        height: 2
        Layout.fillWidth: true
        color: "grey"
    }

    Rectangle {
        Layout.fillWidth:  true
        height: 200
//        Layout.fillHeight: true
        Text {
            text: "<h1>关于DatisCodeViewer<h1><br><div>作者：carlnerv<br>反馈
<br>使用库：Qt 5.8</div>"
        }
    }

    FileDialog {
        id: fileDialog
        title: "打开Message.xml文件"
        nameFilters: [ "Message文件 (Message.xml)" ]
        onAccepted: {
            var furl = String(fileUrl);
            openFileButton.text = furl.slice(8); // 切掉file://，从第8个字符开始
            xmlModel.source = fileUrl;
//            page1.datisVersion = xmlModel.get(0).ATISVersion;
//            page1.rwyText = xmlModel.get(0).ArrRwy;
//            page1.datisTime = xmlModel.get(0).UpdateTime;
//            page1.datisOverTime = xmlModel.get(0).ExpiredTime;
            close();
        }
        onRejected: {
            close();
        }
    }

} // columnLayout


