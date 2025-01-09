import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "./"

Dialog {
    id: tableDialog
    title: {
        if (requestDataType == "aircraft") tableDialog.title = "기체 등록 리스트"
        else if(requestDataType == "battery") tableDialog.title = "배터리 등록 리스트"
        else tableDialog.title = "운용자 등록 리스트"
    }
    width: parent.width * 0.9
    height: parent.height * 0.6
    onAccepted: close()
    onRejected: close()

    property var requestDataType: ""

    property var aircraftName: ""
    property var aircraftRegisterNum: ""
    property var aircraftSerialNum: ""
    property var aircraftMTOW: ""
    property var aircraftType: ""
    property var aircraftDescription: ""

    property var batterySerialNum: ""
    property var batteryType: ""
    property var batteryCapacity: ""
    property var batteryCells: ""
    property var totalUsingTime : ""

    property var operatorName: ""
    property var phoneNumber: ""
    property var position: ""
    property var teamName: ""
    property var certification: ""

    property var externalName : ""
    property var internalName : ""
    property var externalId : ""
    property var internalId : ""

    property var listItemChecked: false
    property var checkedItemIndex : 0
    property var listModel : ListModel

    ColumnLayout{

      Connections{
          target: apiManager
          function onAircraftRequestFinished(){
            listView_1.model = DataModel.aircraftModel
          }
          function onBatteryRequestFinished(){
            listView_1.model = DataModel.battryModel
          }
          function onOperatorRequestFinished(){
            listView_1.model = DataModel.operatorModel;
          }
        }

      anchors.fill: parent
      DialogButtonBox {
          Layout.preferredWidth : parent.width
          Layout.preferredHeight: parent.height * 0.15
          Button {
              text: qsTr("사용")
              DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
              onClicked: {
                tableDialog.accepted()
              }
          }
          Button {
              text: qsTr("삭제")
              DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
              onClicked: {
                  tableDialog.listItemChecked = false;
                  alertMessage.message = "선택한 항목을 삭제하시겠습니까?"
                  alertMessage.isDelete = true
                  alertMessage.open()
                  if (requestDataType == "aircraft"){
                    alertMessage.dataType = "aircraft"
                  }
                  else if (requestDataType == "battery"){
                    alertMessage.dataType = "battery"
                  }
                  else{
                    alertMessage.dataType = "operator"
                  }
              }
          }
      }
      CustomMessageDialog {
        id : alertMessage
      }

      ListView {
        id: listView_1
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height * 0.7
        spacing : 25
        focus : true
        interactive: true
              delegate:
                  Item {
                  id : listItem
                  width: listView_1.width
                  height: 50

                  Rectangle
                  {
                    id : listItemRec
                    color : Material.color(Material.Grey, Material.Shade800)
                    border.color: "white"
                    width: tableDialog.width * 0.9
                    height: tableDialog.height / 10
                    radius : 5

                    RowLayout {
                       CheckBox {
                         id : listViewCheckbox
                         checked: false
                         onCheckedChanged: {
                           //!NOTE : 이미 한번 체크박스를 선택한 경우
                           if(tableDialog.listItemChecked){
                               //!NOTE : 선택한 체크박스가 본인인 경우
                               if (index == checkedItemIndex) {
                                 //!NOTE : 체크박스의 상태를 되돌린다
                                 listItemRec.color = Material.color(Material.Grey, Material.Shade800)
                                 tableDialog.listItemChecked = false
                                 listViewCheckbox.checked = false
                                 return
                               }
                               //!NOTE : 2개이상의 체크박스를 선택하려 하는경우
                               else{
                                 alertMessage.message = "1개의 항목만 선택 가능합니다."
                                 alertMessage.open()
                                 listViewCheckbox.checkState = Qt.Unchecked
                               }
                           }
                           //!NOTE 완전처음 선택하는 경우
                           else{
                             listItemRec.color = "white"
                             tableDialog.listItemChecked = true
                             checkedItemIndex = index
                             alertMessage.currentIndex = checkedItemIndex
                             console.log(alertMessage.currentIndex)
                             if(tableDialog.requestDataType == "aircraft")
                             {
                               DataModel.aircraftName = model.aircraftName
                               tableDialog.aircraftName = model.aircraftName
                               tableDialog.aircraftRegisterNum = model.aircraftRegisterNum
                               tableDialog.aircraftSerialNum = model.aircraftSerialNum
                               tableDialog.aircraftType = model.aircraftType
                               tableDialog.aircraftMTOW = model.aircraftMTOW
                               tableDialog.aircraftDescription = model.aircraftDescription
                             }
                             else if(tableDialog.requestDataType == "battery")
                             {
                               DataModel.batterySerialNum = model.batterySerialNum
                               tableDialog.batterySerialNum = model.batterySerialNum
                               tableDialog.batteryType = model.batteryType
                               tableDialog.batteryCapacity = model.batteryCapacity
                               tableDialog.batteryCells = model.batteryCell
                               tableDialog.totalUsingTime = model.totalUsingTime
                             }
                             else if(tableDialog.requestDataType == "operator")
                             {
                               DataModel.operatorId = model.id
                               tableDialog.operatorName = model.name
                               tableDialog.phoneNumber = model.phoneNumber;
                               tableDialog.position = model.position;
                               tableDialog.teamName = model.teamName;
                               tableDialog.certification = model.certification;
                             }
                             else if(tableDialog.requestDataType == "external"){
                               tableDialog.externalId = model.id
                               tableDialog.externalName = model.name
                             }
                             else if(tableDialog.requestDataType == "internal"){
                               tableDialog.internalId = model.id
                               tableDialog.internalName = model.name
                             }
                           }

                         }
                      }
                      anchors.fill: parent
                      Text
                      {
                        font.bold: true
                        font.pointSize: 12
                        color: "orange"
                        text: {
                            if(tableDialog.requestDataType == "aircraft"){
                              "A/C Name : " + model.aircraftName + "\nRegisNum : " + model.aircraftSerialNum
                            }
                            else if(tableDialog.requestDataType == "battery"){
                              "Battery S/N : " + model.batterySerialNum + "\nType : " + model.batteryType
                            }
                            else "운용자 이름 : " + model.name
                        }
                        width: parent.width / 2
                      }
                    }//RowLayout
                  }//Rectangle
              }//ListView
      }//ColumnLayout
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.100000023841858}
}
##^##*/
