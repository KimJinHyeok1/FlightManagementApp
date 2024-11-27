import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 1.4 as OldControls
import "./CustomComponent"

Item {
    id : flgihtDataRegisterItem
    Rectangle{
        anchors.fill : parent
        color: Material.color(Material.Grey, Material.Shade800)
        ScrollView {
            anchors.fill : parent
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 5
            anchors.bottomMargin: 10
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ColumnLayout {
              Layout.preferredWidth: parent.width - 40
              anchors.fill: parent
              Pane
              {
                contentWidth: layout1.width
                contentHeight: layout1.height
                ColumnLayout
                {
                  id :layout1
                  width : flgihtDataRegisterItem.width
                  Label
                  {
                    id : aircraftName
                    text : "기체명"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "orange"
                  }
                  ComboBox
                  {
                    Layout.preferredWidth: parent.width * 0.9
                    model: [""]
                  }
                  Label
                  {
                    id : batteryType
                    text : "배터리 형식"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "orange"
                  }
                  ComboBox
                  {
                    Layout.preferredWidth: parent.width * 0.9
                    model: [""]
                  }
                  OldControls.TableView{

                  }
                }
              }
            }
        }
    }
}
