import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

Dialog {
    id: tableDialog
    title: "기체 등록 리스트"
    width: parent.width * 0.9
    height: parent.height * 0.6
    onAccepted: console.log("Ok clicked")
    onRejected: console.log("Cancel clicked")

    ListView {
        id: listView_1
        width: tableDialog.width
        height: tableDialog.height * 0.8
        spacing : 25
        model: ListModel {
            ListElement {
                name: "Bill Smith"
                number: "555 3264"
            }
            ListElement {
                name: "John Brown"
                number: "555 8426"
            }
            ListElement {
                name: "Sam Wise"
                number: "555 0473"
            }
        }

        delegate:
            Item {
            width: listView_1.width
            height: 50
            Rectangle
            {
              id : listItem
              color : Material.color(Material.Grey, Material.Shade800)
              border.color: "white"
              width: tableDialog.width * 0.9
              height: tableDialog.height / 10
              radius : 5

              Row {
                 CheckBox {
                   id : listViewCheckbox
                   checked: false

                   onCheckedChanged: {
                     if (checked) {
                       listItem.color = "white"
                     } else {
                       listItem.color = Material.color(Material.Grey, Material.Shade800)
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
        }
    }

    standardButtons: Dialog.Ok | Dialog.Cancel
}
