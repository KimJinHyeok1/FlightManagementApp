import QtQuick 2.10
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.12
import "./CustomComponent"

Item {
    id : aircraftRegisterItem
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
            Layout.preferredWidth: parent.width
            anchors.fill: parent
            Pane
            {
              contentWidth: layout1.width
              contentHeight: layout1.height
              ColumnLayout
              {
                id :layout1
                width : aircraftRegisterItem.width
                Image {
                    id: vesselLogo
                    source: "./icon/vessel.png"
                    sourceSize.height: layout1.height * 0.2
                    sourceSize.width: layout1.width * 0.9
                  }
                  Label
                  {
                    topPadding: 30
                    id : aircraftName
                    text : "1. 기체 명"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  ListViewDialog{
                    id : listViewDialog
                  }

                  RowLayout
                  {
                    Layout.preferredWidth : parent.width * 0.9
                    TextField
                    {
                      id : aircraftNameTextField
                      Layout.preferredWidth : parent.width * 0.8
                      placeholderText: qsTr("기체명을 입력하세요...")
                      color: "orange"
                      text :
                        listViewDialog.aircraftName
                    }
                    Button
                    {
                      icon.source : "./icon/findIcon.png"
                      onClicked : {
                        listViewDialog.open()
                      }
                    }
                  }

                  Label
                  {
                    id : aircraftProductNumber
                    text : "2. 기체 제작번호"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  TextField
                  {
                    id : aircraftRegNumTextField
                    Layout.preferredWidth: parent.width * 0.9
                    placeholderText: qsTr("기체 제작번호를 입력하세요...")
                    text : listViewDialog.aircraftRegisterNum
                    color: "orange"
                  }
                  Label
                  {
                    id : aircraftSerialNumber
                    text : "3. 기체 시리얼번호"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  TextField
                  {
                    id : aircraftSerialNumberTextField
                    Layout.preferredWidth: parent.width * 0.9
                    placeholderText: qsTr("기체 등록번호를 입력하세요...")
                    text : listViewDialog.aircraftSerialNum
                    color: "orange"
                  }
                  Label
                  {
                    id : aircraftType
                    text : "4. 기체 형식"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  ComboBox
                  {
                    id : aircraftTypeComboBox
                    Layout.preferredWidth: parent.width * 0.9
                    model: ["무인멀티콥터", "무인비행기", "복합형(VTOL)"]
                    currentIndex:{
                      if (listViewDialog.aircraftType == "무인멀티콥터")
                         return 0
                      else if(listViewDialog.aircraftType == "무인비행기")
                          return 1
                      else if(listViewDialog.aircraftType == "복합형(VTOL)")
                          return 2
                      else return 2
                    }
                  }
                  Label
                  {
                    id : mtow
                    text : "5. 기체 최대 이륙중량(MTOW)"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  TextField
                  {
                    id : mtowTextField
                    Layout.preferredWidth: parent.width * 0.9
                    placeholderText: qsTr("MTOW를 입력하세요...")
                    text : listViewDialog.aircraftMTOW
                    color: "orange"
                  }
                  Label
                  {
                    id : etc
                    text : "6. 기타 특이사항"
                    Layout.topMargin: 20
                    font.pointSize: 15
                    font.bold : true
                    color: "white"
                  }
                  TextArea
                  {
                    id : etcTextField
                    Layout.preferredWidth: parent.width * 0.9
                    Layout.preferredHeight: 150
                    placeholderText: qsTr("기타 특이사항을 입력하세요...")
                    color : "orange"
                    text : listViewDialog.aircraftDescription
                  }

                  CustomMessageDialog{
                      id : messageDialog
                  }

                  RowLayout
                  {
                    anchors.horizontalCenter: parent
                    Layout.preferredWidth : parent.width * 0.9
                    Button{
                      text : "수정"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked: messageDialog.open()
                    }
                    Button{
                      text : "등록"
                      Layout.preferredWidth : parent.width / 2.1
                      onClicked: {
                          messageDialog.open()
                          DataModel.aircraftName = aircraftNameTextField.text
                          DataModel.aircraftRegisNum = aircraftRegNumTextField.text
                          DataModel.aircraftSerialNum = aircraftSerialNumberTextField.text
                          DataModel.aircraftType = aircraftTypeComboBox.currentValue
                          DataModel.aircraftMtow = mtowTextField.text
                          DataModel.aircraftDescription = etcTextField.text
                          DataModel.aircraftRegisterBtnClicked()
                    }
                  }
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
