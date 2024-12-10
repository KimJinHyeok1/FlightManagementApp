import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "./"

Dialog {
    id: tableDialog
    title: "기체 등록 리스트"
    width: parent.width * 0.9
    height: parent.height * 0.6
    onAccepted: close()
    onRejected: close()

    property var aircraftName: value
    property var aircraftRegisterNum: value
    property var aircraftSerialNum: value
    property var aircraftMTOW: value
    property var aircraftType: value
    property var aircraftDescription: value

    property var listItemChecked: false
    property var listModel: ListModel

    ColumnLayout{

       Component.onCompleted: {
         DataModel.getAircraftData();
       }
       Connections{
           target: apiManager
           onRequestFinished:
               listView_1.model = DataModel.aircraftModel
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
                DataModel.deleteData()
                listView_1.model = DataModel.aircraftModel
              }
          }


      }
      CustomMessageDialog{
        id : alertMessage
      }

      ListModel{

      }

      ListView {
        id: listView_1
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height * 0.7
        spacing : 25
        model : DataModel.aircraftModel
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
                           if(tableDialog.listItemChecked){
                               if (!checked) {
                                 listItemRec.color = Material.color(Material.Grey, Material.Shade800)
                                 tableDialog.listItemChecked = false
                                 return
                               }
                               listViewCheckbox.checkState = Qt.Unchecked
                               alertMessage.message = "1개의 항목만 선택 가능합니다."
                               alertMessage.open()
                           }
                           else{
                               if (checked) {
                                 listItemRec.color = "white"
                                 tableDialog.aircraftName = model.aircraftName
                                 DataModel.aircraftName = model.aircraftName
                                 tableDialog.aircraftRegisterNum = model.aircraftRegisterNum
                                 tableDialog.aircraftSerialNum = model.aircraftSerialNum
                                 tableDialog.aircraftType = model.aircraftType
                                 tableDialog.aircraftMTOW = model.aircraftMTOW
                                 tableDialog.aircraftDescription = model.aircraftDescription
                                 tableDialog.listItemChecked = true
                               } else {
                                 listItemRec.color = Material.color(Material.Grey, Material.Shade800)
                                 tableDialog.listItemChecked = false
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
                        text: "A/C Name : " + model.aircraftName + "\nRegisNum : " + model.aircraftSerialNum
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
