import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12


ApplicationWindow {

    id : mainWindow
    visible: true
    width: 500
    height: 1000
    Material.theme: Material.Dark
    Material.accent: Material.Pulple
    title: qsTr("Flight Log App")

    StackView
    {
      id: stackView
      anchors.fill: parent
      initialItem: "qrc:/homeView.qml"
    }

    property real fontSize_data: 12

    header: ToolBar {
        id : ui_toolbar
        width : mainWindow.width

        RowLayout {
            width : mainWindow.width
            ToolButton{
                icon.source: "./icon/drawer_menu.png"
                onClicked: drawer.open()
            }
            Text {
                id : toolbarText
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: 'Orange'
                font.bold: true
                font.pointSize: 15
                text: qsTr("비행시험팀 비행이력 관리 프로그램")
            }
        }

    Drawer {
      id: drawer
      width: 0.33 * mainWindow.width
      height: mainWindow.height

      ColumnLayout{
      Layout.fillWidth: true
        Image{
          Layout.topMargin: 50
          Layout.bottomMargin: 50
          Layout.alignment: Qt.AlignCenter
          source: "./icon/vessel.png"
          sourceSize.width: drawer.width * 0.9
          sourceSize.height: drawer.height * 0.3
          MouseArea{
            anchors.fill : parent
            onClicked: {
              drawer.close()
              stackView.push("qrc:/homeView.qml")
            }
          }
        }

              ToolButton {
                Layout.preferredWidth: drawer.width
                font.pointSize: fontSize_data
                font.bold : true
                text: "기체 등록"
                onClicked: {
                    mainWindow.width = 500
                    mainWindow.height = 1000
                    drawer.close();
                    toolbarText.text = "기체 등록 관리"
                    stackView.push("qrc:/aircraftRegisterView.qml");
                }
              }
              ToolButton {
                Layout.preferredWidth: drawer.width
                font.pointSize: fontSize_data
                font.bold : true
                text: "배터리 등록"
                onClicked: {
                    mainWindow.width = 500
                    mainWindow.height = 1000
                    drawer.close();
                    toolbarText.text = "배터리 관리"
                    stackView.push("qrc:/batteryRegisterView.qml");
                }
              }
              ToolButton {
                Layout.preferredWidth: drawer.width
                font.pointSize: fontSize_data
                font.bold : true
                text: "운용자 등록"
                onClicked: {
                    mainWindow.width = 500
                    mainWindow.height = 1000
                    drawer.close();
                    toolbarText.text = "운용자 관리"
                    stackView.push("qrc:/operatorRegisterView.qml");
                }
              }
              ToolButton {
                Layout.preferredWidth: drawer.width
                font.pointSize: fontSize_data
                font.bold : true
                text: "비행 데이터 등록"
                onClicked: {
                    mainWindow.width = 500
                    mainWindow.height = 1000
                    drawer.close();
                    toolbarText.text = "비행 데이터 등록 관리"
                    stackView.push("qrc:/flightDataRegisterView.qml");
                }
              }
              ToolButton {
                Layout.preferredWidth: drawer.width
                font.pointSize: fontSize_data
                font.bold : true
                text: "비행 이력 검색"
                onClicked: {
                    drawer.close();
                    mainWindow.width = 1400
                    mainWindow.height = 1000
                    toolbarText.text = "비행 이력 검색"
                    stackView.push("qrc:/flightLogView.qml");
                }
              }
          }
      }
    }
}



