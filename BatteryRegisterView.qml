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
            anchors.fill: parent
            Pane
            {
              contentWidth: layout1.width
              contentHeight: layout1.height
              ColumnLayout
              {
                id :layout1
                width : batteryRegisterItem.width
                Image {
                    id: vesselLogo
                    source: "./icon/vessel.png"
                    sourceSize.height: layout1.height * 0.2
                    sourceSize.width: layout1.width * 0.9
                  }
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
                    model: ["Lipo", "Li-ion", "LiCa", "기타"]
                    currentIndex:{
                      if (batteryListViewDialog.batteryCells === "Lipo")
                         return 0
                      else if(batteryListViewDialog.batteryCells === "Li-ion")
                          return 1
                      else if(batteryListViewDialog.batteryCells === "LiCa")
                          return 2
                      else if(batteryListViewDialog.batteryCells === "기타")
                          return 3
                      else return 0
                    }
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
                      model: ["1", "2", "3", "4", "5", "6",
                      "8", "10", "12", "16", "24"]
                      currentIndex: {
                            if (batteryListViewDialog.batteryCells === "1")
                               return 0
                            else if(batteryListViewDialog.batteryCells === "2")
                                return 1
                            else if(batteryListViewDialog.batteryCells === "3")
                                return 2
                            else if(batteryListViewDialog.batteryCells === "4")
                                return 3
                            else if(batteryListViewDialog.batteryCells === "4")
                                return 4
                            else if(batteryListViewDialog.batteryCells === "5")
                                return 5
                            else if(batteryListViewDialog.batteryCells === "6")
                                return 6
                            else if(batteryListViewDialog.batteryCells === "8")
                                return 7
                            else if(batteryListViewDialog.batteryCells === "10")
                                return 8
                            else if(batteryListViewDialog.batteryCells === "12")
                                return 9
                            else if(batteryListViewDialog.batteryCells === "16")
                                return 10
                            else if(batteryListViewDialog.batteryCells === "24")
                                return 11
                            else return 0
                        }
                    }
                    Label{
                      leftPadding: 15
                      Layout.alignment: Qt.AlignLeft
                      text: "(Cells)"
                      font.pointSize: 15
                      font.bold: true
                      color:"orange"
                    }
                  }

                  CustomMessageDialog{
                      id : messageDialog
                      dataType: "battery"
                  }


                  RowLayout
                  {
                    Layout.topMargin: 50
                    anchors.horizontalCenter: parent
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
            }//pane
          }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
