import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Dialog {
    id: tableDialog
    title: "기체 등록 리스트"
    width: parent.width * 0.9
    height: parent.height * 0.6
    onAccepted: close()
    onRejected: console.log("Cancel clicked")

    property var aircarftName: value
    property var listItem: value

    ColumnLayout{
      anchors.fill: parent
      DialogButtonBox {
          Layout.preferredWidth : parent.width
          Layout.preferredHeight: parent.height * 0.15
          Button {
              text: qsTr("등록")
              DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
              onClicked: {
                  tableDialog.accepted()
              }
          }
          Button {
              text: qsTr("삭제")
              DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
          }
      }
      ListView {

        id: listView_1
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height
        spacing : 25
        model: ListModel {
               ListElement {
                 name: "HL3432"
                 regisNum: "5553264"
               }
               ListElement {
                 name: "HL3433"
                 regisNum: "5558426"
               }
               ListElement {
                 name: "HL3434"
                 regisNum: "5550473"
               }
               ListElement {
                 name: "HL3435"
                 regisNum: "5553264"
               }
               ListElement {
                 name: "HL3436"
                 regisNum: "5558426"
               }
             }
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
                           if (checked) {
                             listItemRec.color = "white"
                             tableDialog.aircarftName = name

                           } else {
                             listItemRec.color = Material.color(Material.Grey, Material.Shade800)
                           }
                         }
                       }
                      anchors.fill: parent
                      Text
                      {
                        font.bold: true
                        font.pointSize: 12
                        text: model.name
                        width: parent.width / 2
                      }
                      Text
                      {
                        font.bold: true
                        font.pointSize: 12
                        text: model.number
                        width: parent.width / 2
                      }
                    }
                  }
              }//ListView
      }//ColumnLayout
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.100000023841858}
}
##^##*/
