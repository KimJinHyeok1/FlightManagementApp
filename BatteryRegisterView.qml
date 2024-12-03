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

        ScrollView {
            id : scrollView
            anchors.fill : parent
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
          ColumnLayout {
            Layout.preferredWidth: parent.width - 40
            anchors.fill: parent
            Image {
                id: vesselLogo
                source: "./icon/vessel.png"
                sourceSize.height: layout1.height * 0.2
                sourceSize.width: layout1.width * 0.9
              }
            Pane
            {
              contentWidth: scrollView.width
              contentHeight: scrollView.height
              ColumnLayout
              {
                id :layout1
                width : batteryRegisterItem.width
                  Label
                  {
                    topPadding: 30
                    id : batteryType
                    text : "1. 배터리 타입(종류)"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  ComboBox
                  {
                    Layout.preferredWidth: parent.width * 0.9
                    model: ["Lipo", "Li-ion", "LiCa", "기타"]

                  }


                  Label
                  {
                    id : mtow
                    text : "2. 배터리 용량"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  TextField
                  {
                    Layout.preferredWidth: parent.width * 0.9
                    placeholderText: qsTr("MTOW를 입력하세요...")
                  }
                  Label
                  {
                    id : additionalInfo
                    text : "5. 배터리 번호(S/N)"
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
                      Layout.preferredWidth: parent.width * 0.7
                      placeholderText: qsTr("기체 비행시간...")
                    }
                    Button
                    {
                      icon.source : "./icon/findIcon.png"
                    }
                  }

                  CustomMessageDialog{
                      id : messageDialog
                  }


                  RowLayout
                  {
                    Layout.topMargin: 50
                    anchors.horizontalCenter: parent
                    Layout.preferredWidth : parent.width * 0.9
                    Button{
                      text : "수정"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked : messageDialog.open()
                    }
                    Button{
                      text : "등록"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked : messageDialog.open()
                    }
                  }
              }

            }
          }
        }

    }
}
