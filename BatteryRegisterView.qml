import QtQuick 2.10
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.12
import "./CustomComponent"

Item {
    id : batteryRegisterItem
    Rectangle{
        anchors.fill : parent
        color: Material.color(Material.Grey, Material.Shade800)

        ListViewDialog{
          id : batteryListViewDialog
        }
        ScrollView {
            id : scrollView
            anchors.fill : parent
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 5
            anchors.bottomMargin: 10
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
          ColumnLayout {
            Layout.preferredWidth: parent.width
            Label
            {
              text : "배터리 S/N 입력 및 조회"
              Layout.topMargin: 24
              Layout.bottomMargin: 15
              font.pointSize: 15
              font.bold : true
              color: "orange"
            }
            Pane
            {
              contentWidth: layout1.width
              contentHeight: layout1.height
              ColumnLayout
              {
                id :layout1
                width : batteryRegisterItem.width
                  Label
                  {
                    id : batterySerialNumber
                    text : "1. 배터리 S/N"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  RowLayout
                  {
                    Layout.preferredWidth : parent.width * 0.9
                    TextField
                    {
                      id : batterySerialNumberTextField
                      text : batteryListViewDialog.batterySerialNum
                      Layout.preferredWidth: parent.width * 0.7
                      placeholderText: qsTr("기체 비행시간...")
                      color:"orange"
                    }
                    Button
                    {
                      icon.source : "./icon/findIcon.png"
                      onClicked: {
                        batteryListViewDialog.open()
                        batteryListViewDialog.requestDataType = "battery"
                        DataModel.getBatteryData()
                      }
                    }
                  }
              }//ColumnLayout
            }//Pane
          Label
          {
            text : "배터리 정보"
            Layout.topMargin: 24
            Layout.bottomMargin: 15
            font.pointSize: 15
            font.bold : true
            color: "orange"
          }
          Pane{
            contentWidth: layout2.width
            contentHeight: layout2.height

            ColumnLayout
            {
              id :layout2
              width : batteryRegisterItem.width
                  Label
                  {
                    topPadding: 30
                    id : batteryType
                    text : "2. 배터리 타입(종류)"
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  ComboBox
                  {
                    id : batteryTypeComboBox
                    Layout.preferredWidth: parent.width * 0.9
                    model : DataModel.batteryTypeList
                    currentIndex: model.indexOf(batteryListViewDialog.batteryType)
                  }


                  Label
                  {
                    id : batteryCapacity
                    text : "3. 배터리 용량"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  RowLayout{
                    Layout.preferredWidth: parent.width * 0.9
                      TextField
                      {
                        id : capacityTextField
                        Layout.preferredWidth: parent.width * 0.7
                        placeholderText: qsTr("배터리 용량을 입력하세요")
                        text : batteryListViewDialog.batteryCapacity
                        color:"orange"
                      }
                      Label{
                        leftPadding: 15
                        text: "(mAh)"
                        font.pointSize: 15
                        font.bold: true
                        color:"orange"
                      }
                  }


                  Label
                  {
                    id : additionalInfo
                    text : "4. 배터리 Cell"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }

                  RowLayout{
                    Layout.preferredWidth: parent.width * 0.9
                    ComboBox
                    {
                      id : cellCombobox
                      Layout.preferredWidth: parent.width * 0.5
                      model : DataModel.batteryCellList
                      currentIndex: model.indexOf(batteryListViewDialog.batteryCells.toString())
                    }
                    Label{
                      leftPadding: 15
                      Layout.alignment: Qt.AlignLeft
                      text: "(Cells)"
                      font.pointSize: 15
                      font.bold: true
                      color:"orange"
                    }
                  }//RowLayout
            }//Layout2
        }//Pane2
        Label
        {
          text : "배터리 총 사용시간"
          Layout.topMargin: 24
          Layout.bottomMargin: 15
          font.pointSize: 15
          font.bold : true
          color: "orange"
        }
          Pane{
            contentWidth: layout3.width
            contentHeight: layout3.height
            ColumnLayout
            {
              id :layout3
              width : batteryRegisterItem.width
                  Label
                  {
                    id : usingTime
                    text : "5. 총 사용시간"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  RowLayout{
                    Layout.preferredWidth: parent.width * 0.9
                    Label
                    {
                      id : usingTimeLabel
                      Layout.topMargin: 20
                      font.pointSize: 15
                      font.bold : true
                      color: "white"
                      text : batteryListViewDialog.totalUsingTime
                    }
                    Label{
                      leftPadding: 15
                      Layout.alignment: Qt.AlignLeft
                      Layout.topMargin: 20
                      text: "Min"
                      font.pointSize: 15
                      font.bold: true
                      color:"orange"
                    }
                  }
                } //Layout3
              }  //Pane3

                  CustomMessageDialog{
                      id : messageDialog
                      dataType: "battery"
                  }


                  RowLayout
                  {
                    Layout.topMargin: 50

                    Layout.preferredWidth : parent.width * 0.9
                    Button{
                      text : "수정"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked : {
                        DataModel.batterySerialNum = batterySerialNumberTextField.text
                        DataModel.batteryType = batteryTypeComboBox.currentText
                        DataModel.batteryCapacity = capacityTextField.text
                        DataModel.batteryCells = cellCombobox.currentText
                        messageDialog.message = "수정하시겠습니까?"
                        messageDialog.isRegister = false;
                        messageDialog.open()
                      }
                    }
                    Button{
                      text : "등록"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked : {
                        DataModel.batterySerialNum = batterySerialNumberTextField.text
                        DataModel.batteryType = batteryTypeComboBox.currentText
                        DataModel.batteryCapacity = capacityTextField.text
                        DataModel.batteryCells = cellCombobox.currentText
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
