import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 1.4 as OldControls
import "./CustomComponent"

Item {
  id : flightLogViewItem
  width: 1400
  height: 1000

  Rectangle{
    anchors.fill : parent
    color: Material.color(Material.Grey, Material.Shade800)

    ScrollView {
      id : scrollView
      anchors.fill : parent
      anchors.topMargin: 0
      anchors.leftMargin: 10
      anchors.rightMargin: 5
      anchors.bottomMargin: 10
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

    ColumnLayout{
      anchors.fill : parent

      Label
      {
        text : "비행 이력 검색"
        Layout.topMargin: 24
        Layout.bottomMargin: 15
        font.pointSize: 15
        font.bold : true
        color: "orange"
      }

      Pane{
        Layout.preferredWidth : flightLogViewItem.width
        RowLayout{
          id : buttonLayout
          width : flightLogViewItem.width
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.2
            text : "기체별 검색"
            onClicked: {
                DataModel.getFlightData()
            }
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.2
            text : "배터리별 검색"
            onClicked: {
              flightDataTalbeView.model = DataModel.flightDataModel
            }
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.2
            text : "날짜별 검색"
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.2
            text : "운용자별 검색"
          }
        }//ButtonLayout
       }//Pane_1

      Label
      {
        text : "검색 비행 이력 결과"
        Layout.topMargin: 24
        Layout.bottomMargin: 15
        font.pointSize: 15
        font.bold : true
        color: "orange"
      }

      Pane{
        Layout.preferredWidth : flightLogViewItem.width
        contentHeight: flightDataTalbeView.height
        OldControls.TableView{
          id : flightDataTalbeView
          width : parent.width * 0.98
          height : flightLogViewItem.height * 0.4

          model : ""

          OldControls.TableViewColumn {
            role: "flightNumber"
            title: "Flight Number"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "flightDate"
            title: "Date"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "aircraft"
            title: "A/C Name"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "battery"
            title: "Battery"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "flightTime"
            title: "Flight Time"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "ep"
            title: "External Pilot"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "ip"
            title: "Internal Pilot"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "payloadItem"
            title: "Payload Type"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "payloadWeight"
            title: "Payload Weight"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "temperature"
            title: "Temp"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "humidity"
            title: "Humid"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "windDirection"
            title: "Wind Direction"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "windSpeed"
            title: "Wind Speed"
            width: 100
          }
        }
      }


      Label
      {
        text : "비행이력 요약 정보"
        Layout.topMargin: 24
        Layout.bottomMargin: 15
        font.pointSize: 15
        font.bold : true
        color: "orange"
      }

      Pane{
        Layout.preferredWidth : flightLogViewItem.width
      }

      }//ColumnLayout
    }//ScrollView
  }//Rectangle
}//Item
