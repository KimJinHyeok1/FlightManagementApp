import QtQuick 2.10
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 1.4 as OldControls
import "./CustomComponent"

Item {
    id : flgihtDataRegisterItem

    property var epName : listViewDialog.externalName
    property var epId : listViewDialog.externalId
    property var ipName : listViewDialog.internalName
    property var ipId : listViewDialog.internalId

    property var batteryListModel : []
    property var batteryList : []

    Rectangle{
        anchors.fill : parent
        color: Material.color(Material.Grey, Material.Shade800)

        ListViewDialog{
          id : listViewDialog
        }

        ScrollView {
            anchors.fill : parent
            anchors.leftMargin: 10
            Component.onCompleted: {
                DataModel.getAircraftData()
                DataModel.getBatteryData()
                DataModel.getOperatorData()
            }
            Connections{
              target: apiManager
              onAircraftRequestFinished:{
                aircraftComboBox.model = DataModel.aircraftList
              }
              onBatteryRequestFinished:{
                batteryComboBox.model = DataModel.batteryList
                //batteryTableView.model = DataModel.battryModel
              }
            }
            ColumnLayout {
              id : fistColumnLayout
              width : flgihtDataRegisterItem.width
              height : flgihtDataRegisterItem.height
              Image {
                id: vesselLogo
                source: "./icon/vessel.png"
                sourceSize.height: fistColumnLayout.height * 0.25
                sourceSize.width: fistColumnLayout.width * 0.9
              }
              Label
              {
                Layout.topMargin: 24
                Layout.bottomMargin: 15
                text : "비행 기본정보"
                font.pointSize: 15
                font.bold : true
                color: "orange"
              }
              Pane
              {
                id : pane1
                Layout.preferredWidth: parent.width
                ColumnLayout
                {
                  id :layout1
                  width : fistColumnLayout.width
                  //width : pane1.width
                  Label
                  {
                    id : aircraftName
                    text : "1. 기체명"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  ComboBox
                  {
                    id : aircraftComboBox
                    Layout.preferredWidth: parent.width * 0.9
                  }
                  Label
                  {
                    id : batteryType
                    text : "2. 배터리 형식"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }

                  RowLayout
                  {
                    Layout.preferredWidth: parent.width * 0.9
                    ComboBox
                    {
                      Layout.preferredWidth: parent.width * 0.65
                      id : batteryComboBox
                    }
                    Button {
                      id : appendButton
                      text : "+"
                      onClicked: {
                        DataModel.getSpecificBatteryData(batteryComboBox.currentText)
                      }
                    }

                    Connections{
                      target: DataModel
                      onOperationFinished : {
                        tableModel.append({
                          batterySerialNum : DataModel.batterySerialNum,
                          batteryCapacity : DataModel.batteryCapacity,
                          batteryCell : DataModel.batteryCells,
                          batteryType : DataModel.batteryType
                       })
                      }
                    }
                    Button {
                      id : deleteButton
                      text : "-"
                      onClicked: {
                        tableModel.remove(batteryTableView.currentRow)
                      }
                    }
                  }

                  OldControls.TableView{
                    id : batteryTableView
                    Layout.preferredWidth: parent.width * 0.9

                    model : ListModel{
                      id : tableModel
                    }

                    OldControls.TableViewColumn {
                      role: "batterySerialNum"
                      title: "Battery S/N"
                      width: 100
                    }
                    OldControls.TableViewColumn {
                      role: "batteryType"
                      title: "Type"
                      width: 80
                    }
                    OldControls.TableViewColumn {
                      role: "batteryCapacity"
                      title: "Capacity(mAh)"
                      width: 150
                    }
                    OldControls.TableViewColumn {
                      role: "batteryCell"
                      title: "Cells"
                      width: 50
                    }
                  }

                  Label
                  {
                    id : flightDate
                    text : "3. 비행 일자"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  OldControls.Calendar{
                    id : calendar
                    Layout.preferredWidth: parent.width * 0.9
                    onClicked: {
                      DataModel.date = selectedDate
                    }
                  }
                }
              }
              Label
              {
                Layout.topMargin: 24
                Layout.bottomMargin: 15
                text : "기상"
                font.pointSize: 15
                font.bold : true
                color: "orange"
              }
              Pane{
                contentWidth: layout1.width
                ColumnLayout
                {
                  width : flgihtDataRegisterItem.width
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.2
                      text : "1. 풍향"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : windDirectionTextField
                      Layout.preferredWidth : parent.width * 0.6
                      placeholderText: qsTr("풍향을 입력하세요...")
                      text : DataModel.windDirection
                      validator: IntValidator{
                        bottom : 0;
                        top : 360;
                      }
                    }
                    Label
                    {
                      text : "º"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                  }
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.2
                      text : "2. 풍속"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : windSpeedTextField
                      Layout.preferredWidth : parent.width * 0.6
                      placeholderText: qsTr("풍속을 입력하세요...")
                      text : DataModel.windSpeed
                      validator: IntValidator{
                        bottom : 0;
                        top : 100;
                      }
                    }
                    Label
                    {
                      text : "㎧"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                  }
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.2
                      text : "3. 습도"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : humidityTextField
                      Layout.preferredWidth : parent.width * 0.6
                      placeholderText: qsTr("습도를 입력하세요...")
                      text : DataModel.humidity
                      validator: IntValidator{
                        bottom : 0;
                        top : 100;
                      }
                    }
                    Label
                    {
                      text : "%"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                  }
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.2
                      text : "4. 온도"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : temperatureTextField
                      Layout.preferredWidth : parent.width * 0.6
                      placeholderText: qsTr("온도를 입력하세요...")
                      text : DataModel.tempzerature
                      validator: IntValidator{
                        bottom : 0;
                        top : 100;
                      }
                    }
                    Label
                    {
                      text : "℃"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                  }
                }
              }
              Label
              {
                Layout.topMargin: 24
                Layout.bottomMargin: 15
                text : "운용자"
                font.pointSize: 15
                font.bold : true
                color: "orange"
              }
              Pane{
                contentWidth: layout1.width
                ColumnLayout
                {
                  width : flgihtDataRegisterItem.width
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.4
                      text : "1. EP(외부조종자)"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : epTextField
                      Layout.preferredWidth : parent.width * 0.4
                      placeholderText: qsTr("EP를 입력하세요...")
                      text : epName
                    }
                    Button
                    {
                      icon.source : "./icon/findIcon.png"
                      onClicked : {
                        listViewDialog.requestDataType = "external"
                        listViewDialog.open()
                      }
                    }
                  }
                  RowLayout {
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.4
                      text : "2. IP(내부조종자)"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    TextField
                    {
                      id : ipTextField
                      Layout.preferredWidth : parent.width * 0.4
                      placeholderText: qsTr("IP를 입력하세요...")
                      text : ipName
                    }
                    Button
                    {
                      icon.source : "./icon/findIcon.png"
                      onClicked : {
                        listViewDialog.requestDataType = "internal"
                        listViewDialog.open()
                      }
                    }
                  }
                }
              }
              Label
              {
                Layout.topMargin: 24
                Layout.bottomMargin: 15
                text : "기타"
                font.pointSize: 15
                font.bold : true
                color: "orange"
              }
              Pane{
                contentWidth: layout1.width
                ColumnLayout
                {
                  width : flgihtDataRegisterItem.width
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.25
                      text : "1. 비행시간"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                    RowLayout{
                      TimePicker{
                        id : startTime
                        Component.onCompleted: set(new Date(0, 0, 0, 0, 0)) // 12:00 AM
                        onClicked: DataModel.startTime = Qt.formatTime(date, 'hh:mm')
                      }
                      Label{
                        text: "~"
                        font.pointSize: 15
                        font.bold : true
                      }
                      TimePicker{
                        id : endTime
                        Component.onCompleted: set(new Date(0, 0, 0, 0, 0)) // 12:00 AM
                        onClicked: DataModel.endTime = Qt.formatTime(date, 'hh:mm')
                      }
                    }
                  }
                  RowLayout{
                    Layout.preferredWidth : parent.width * 0.9
                    Label
                    {
                      Layout.preferredWidth: parent.width * 0.2
                      text : "2. 페이로드"
                      font.pointSize: 14
                      font.bold : true
                      color: "white"
                    }
                    ComboBox
                    {
                      id : payloadCombobox
                      Layout.preferredWidth: parent.width * 0.3
                      model: ["카메라", "배송장치", "기타"]
                    }
                    TextField
                    {
                      id : payloadTextField
                      Layout.preferredWidth : parent.width * 0.3
                      placeholderText: qsTr("중량을 입력하세요...")
                    }
                    Label
                    {
                      text : "Kg"
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                    }
                  }
                }
              }

              CustomMessageDialog{
                  id : messageDialog
                  dataType: "flightData"
              }

              RowLayout{
                Layout.preferredWidth: parent.width
                Button{
                  Layout.alignment: Qt.AlignHCenter
                  Layout.preferredWidth: parent.width * 0.7
                  Layout.topMargin: 20
                  Layout.bottomMargin: 40
                  text: "등록하기"
                  onClicked: {
                    batteryList = []
                    for(var i = 0; i < tableModel.count; ++i){
                      batteryList.push(tableModel.get(i)["batterySerialNum"])
                    }

                    DataModel.flightBatteryList = batteryList
                    DataModel.aircraftName = aircraftComboBox.currentText;
                    DataModel.windDirection = windDirectionTextField.text;
                    DataModel.externalPilot = epId;
                    DataModel.internalPilot = ipId;
                    DataModel.windSpeed = windDirectionTextField.text;
                    DataModel.humidity = humidityTextField.text;
                    DataModel.temperature = temperatureTextField.text;
                    DataModel.flightDate = calendar.selectedDate;
                    DataModel.payloadType = payloadCombobox.currentText;
                    DataModel.payloadWeight = payloadTextField.text;
                    messageDialog.message = "등록하시겠습니까?"
                    messageDialog.isRegister = true;
                    messageDialog.open()
                  }
                }
              }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
