import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 1.4 as OldControls
import "./CustomComponent"

Item {
  id : flightLogViewItem

  Component.onCompleted: {
    DataModel.getOperatorData();
    DataModel.getAircraftData();
  }

  Connections {
    target : apiManager
    onAircraftRequestFinished:{
      aircraftNameCombobox.model = DataModel.aircraftList
    }
    onOperatorRequestFinished:{
      operatorNameCombobox.model = DataModel.operatorList
    }
  }

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
            Layout.preferredWidth: buttonLayout.width * 0.18
            text : "전체 조회"
            onClicked: {
              DataModel.getFlightData()
            }
            Connections{
              target: apiManager
              onFlightDataRequestFinished : {
                flightDataTalbeView.model = ""
                totalFlightNum.text = DataModel.getFlightNum()
                totalFlightTime.text = DataModel.getTotalFlightTime()
                totalFlightDay.text = DataModel.getTotalFlightDate()
                flightDataTalbeView.model = DataModel.flightDataModel
              }
            }
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.18
            text : "기체별 검색"
            onClicked: {
              findLabel.visible = true
              findAircraftNamePane.visible = true
              findDatePane.visible = false
              findOperatorNamePane.visible = false
            }
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.18
            text : "날짜별 검색"
            onClicked:{
              findLabel.visible = true
              findAircraftNamePane.visible = false
              findDatePane.visible = true
              findOperatorNamePane.visible = false
            }
          }
          Button{
            Layout.preferredWidth: buttonLayout.width * 0.18
            text : "운용자별 검색"
            onClicked: {
              findLabel.visible = true
              findAircraftNamePane.visible = false
              findDatePane.visible = false
              findOperatorNamePane.visible = true
            }
          }
        }//ButtonLayout
       }//Pane_1

      Label
      {
        id : findLabel
        visible: false
        text : "조건 검색"
        Layout.topMargin: 24
        Layout.bottomMargin: 15
        font.pointSize: 15
        font.bold : true
        color: "orange"
      }
      Pane{
        id : findAircraftNamePane
        Layout.preferredWidth : flightLogViewItem.width
        visible: false
        RowLayout{
          spacing: 0
          Label
          {
            id : acLabel
            text : "Aircraft Name : "
            font.pointSize: 12
            font.bold : true
            color: "white"
          }
          ComboBox{
            Layout.preferredWidth: parent.width * 0.5
            id : aircraftNameCombobox
            Layout.leftMargin: 15
            model : DataModel.aircraftList
          }
          Button
          {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 15
            icon.source : "./icon/findIcon.png"
            onClicked : {
              DataModel.getFlightDataByAircraftName(aircraftNameCombobox.currentText)
            }
          }
        }
      }//findAircraftNamePane

      Pane{
        id : findDatePane
        Layout.preferredWidth : flightLogViewItem.width
        visible: false
        RowLayout{
          Label
          {
            text : "Start Date : "
            font.pointSize: 12
            font.bold : true
            color: "white"
          }
          Button
          {
            id : startDatePickerButton
            text : startDateCalender.selectedDate
            onClicked : {
              startDatePickerPopup.open()
            }
          }
          Popup{
            id : startDatePickerPopup
            x : startDatePickerButton.x
            RowLayout{
              ColumnLayout{
                Label
                {
                  text : "Start Date"
                  font.pointSize: 15
                  font.bold : true
                  color: "white"
                  Layout.bottomMargin: 15
                }
                OldControls.Calendar{
                  id : startDateCalender
                }
              }
            }
          }
          Label{
            text : " ~ "
            font.pointSize: 12
            font.bold : true
          }
          Label
          {
            text : "End Date : "
            font.pointSize: 12
            font.bold : true
            color: "white"
          }
          Button
          {
            id : endDatePickerButton
            text : endDateCalender.selectedDate
            onClicked : {
              endDatePickerPopup.open()
            }
          }
          Popup{
            id : endDatePickerPopup
            x : endDatePickerButton.x
            RowLayout{
              ColumnLayout{
                Label
                {
                  text : "Start Date"
                  font.pointSize: 15
                  font.bold : true
                  color: "white"
                  Layout.bottomMargin: 15
                }
                OldControls.Calendar{
                  id : endDateCalender
                }
              }
            }
          }
          Button
          {
            icon.source : "./icon/findIcon.png"
            Layout.leftMargin: 15
            onClicked : {
              DataModel.getFlightDataByDate(startDateCalender.selectedDate,
                                            endDateCalender.selectedDate)
            }
          }
        }
      }//findAircraftNamePane

      Pane{
        id : findOperatorNamePane
        Layout.preferredWidth : flightLogViewItem.width
        visible: false
        RowLayout{
          Label
          {
            text : "Operator Name : "
            font.pointSize: 12
            font.bold : true
            color: "white"
          }
          ComboBox{
            id : operatorNameCombobox
            Layout.preferredWidth: parent.width * 0.5
            model : DataModel.aircraftList
          }
          Button
          {
            icon.source : "./icon/findIcon.png"
            Layout.leftMargin: 15
            onClicked : {
              DataModel.getFlightDataByOperatorName(operatorNameCombobox.currentText)
            }
          }
        }
      }//findAircraftNamePane

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
          OldControls.TableViewColumn {
            id : checkboxColumn
            role: " "
            title: " "
            width: 25
            delegate:
              ItemDelegate{
              CheckBox {
                width : checkboxColumn.width
              }
            }
          }
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
            role: "aircraftName"
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
            role: "humidity"
            title: "Humid"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "temperature"
            title: "Temp"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "windSpeed"
            title: "Wind Speed"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "windDirection"
            title: "Wind Direction"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "externalPilot"
            title: "External Pilot"
            width: 100
          }
          OldControls.TableViewColumn {
            role: "internalPilot"
            title: "Internal Pilot"
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
        ColumnLayout{
          RowLayout{
            Layout.bottomMargin: 20
            Label
            {
              text : "총 비행횟수(소티) : "
              font.pointSize: 15
              font.bold : true
              color: "white"
            }
            Label
            {
              id : totalFlightNum
              font.pointSize: 12
              font.bold : true
              color: "orange"
            }
          }
          RowLayout{
            Layout.bottomMargin: 20
            Label
            {
              text : "총 비행시간(분) : "
              font.pointSize: 15
              font.bold : true
              color: "white"
            }
            Label
            {
              id : totalFlightTime
              font.pointSize: 12
              font.bold : true
              color: "orange"
            }
          }
          RowLayout{
            Label
            {
              text : "총 비행일수(일) : "
              font.pointSize: 15
              font.bold : true
              color: "white"
            }
            Label
            {
              id : totalFlightDay
              font.pointSize: 12
              font.bold : true
              color: "orange"
            }
          }
        }
      }
      }//ColumnLayout
    }//ScrollView
  }//Rectangle
}//Item

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
