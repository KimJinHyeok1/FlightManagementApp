import QtQuick 2.10
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.12
import "./CustomComponent"

Item {
  id : operatorRegisterItem
  Rectangle{
    anchors.fill : parent
    color : Material.color(Material.Grey, Material.Shade800)
    ListViewDialog {
      id : operatorListView
    }
    CustomMessageDialog{
      id : messageDialog
      dataType: "operator"
    }

    ScrollView{
      id : scrollView
      anchors.fill : parent
      anchors.topMargin: 0
      anchors.leftMargin: 10
      anchors.rightMargin: 5
      anchors.bottomMargin: 10
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn
      ColumnLayout{
        Layout.preferredWidth: parent.width
        anchors.fill: parent
        Label
        {
          text : "개인정보"
          Layout.topMargin: 24
          Layout.bottomMargin: 15
          font.pointSize: 15
          font.bold : true
          color: "orange"
        }
        Pane
        {
          contentWidth: layout.width
          contentHeight: layout.height
          ColumnLayout
          {
            id :layout
            width : operatorRegisterItem.width
            Label
            {
              id : operatorName
              text : "1. 운용자 이름"
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
                id : operatorNameTextField
                text : operatorListView.operatorName
                Layout.preferredWidth: parent.width * 0.7
                color:"orange"
              }
              Button
              {
                icon.source : "./icon/findIcon.png"
                onClicked: {
                  operatorListView.requestDataType = "operator"
                  DataModel.getOperatorData()
                  operatorListView.open()
                }
              }
            }//RowLayout
            Label
            {
              id : phoneNumber
              text : "2. 전화번호"
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
                id : phoneNumberTextField
                Layout.preferredWidth : parent.width * 0.9
                placeholderText : "  '-'있이 입력하세요"
                text : operatorListView.phoneNumber
                color:"orange"
              }
            }//RowLayout

          }//ColumnLayout
        }//Pane
        Label
        {
          text : "부서정보"
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
              width : operatorRegisterItem.width
            Label
            {
              id : position
              text : "3. 직급"
              Layout.topMargin: 20
              font.pointSize: 15
              font.bold : true
              color: "white"
            }
            ComboBox
            {
              id : positionComboBox
              Layout.preferredWidth: parent.width * 0.9
              model: ["사원", "주임", "대리", "과장", "차장", "부장", "팀장"]
              currentIndex:{
                model.indexOf(operatorListView.position)
              }
            }
            Label
            {
              id : team
              text : "4. 소속 부서"
              Layout.topMargin: 20
              font.pointSize: 15
              font.bold : true
              color: "white"
            }
            ComboBox
            {
              id : teamComboBox
              Layout.preferredWidth: parent.width * 0.9
              model: ["운영팀", "비행시험팀", "지원팀", "개발팀", "인사총무팀", "체계팀", "기타"]
              currentIndex:{
                model.indexOf(operatorListView.teamName)
              }
            }
           }
        }
        Label
        {
          text : "자격정보"
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
              width : operatorRegisterItem.width
              Label
              {
                text : "5. 조종 자격"
                Layout.topMargin: 20
                font.pointSize: 15
                font.bold : true
                color: "white"
              }
              ComboBox
              {
                id : certificatedCombobox
                Layout.preferredWidth: parent.width * 0.9
                model: ["초경량비행장치 무인멀티콥터 1종",
                    "초경량비행장치 무인멀티콥터 2종",
                    "초경량비행장치 무인멀티콥터 3종",
                    "초경량비행장치 무인멀티콥터 4종",
                    "초경량비행장치 무인헬리콥터 1종",
                    "초경량비행장치 무인멀티콥터 2종",
                    "초경량비행장치 무인멀티콥터 3종",
                    "초경량비행장치 무인멀티콥터 4종",
                    "초경량비행장치 무인비행기 1종",
                    "초경량비행장치 무인비행기 2종",
                    "초경량비행장치 무인비행기 3종",
                    "초경량비행장치 무인비행기 4종",
                    ]
                currentIndex:{
                  model.indexOf(operatorListView.certification)
                }
              }
           }
        }

        RowLayout
        {
          Layout.topMargin: 15
          Layout.bottomMargin: 15
          anchors.horizontalCenter: parent
          Layout.preferredWidth : parent.width * 0.9
          Button{
            text : "수정"
            Layout.preferredWidth : parent.width / 2.1
            onClicked : {
              DataModel.operatorName = operatorNameTextField.text
              DataModel.phoneNumber = phoneNumberTextField.text
              DataModel.position = positionComboBox.currentText
              DataModel.certification = certificatedCombobox.currentText
              DataModel.teamName = teamComboBox.currentText
              messageDialog.message = "수정하시겠습니까?"
              messageDialog.isRegister = false;
              messageDialog.open()
            }
          }
          Button{
            text : "등록"
            Layout.preferredWidth : parent.width / 2.1
            onClicked : {
              DataModel.operatorName = operatorNameTextField.text
              DataModel.phoneNumber = phoneNumberTextField.text
              DataModel.position = positionComboBox.currentText
              DataModel.certification = certificatedCombobox.currentText
              DataModel.teamName = teamComboBox.currentText
              messageDialog.message = "등록하시겠습니까?"
              messageDialog.isRegister = true;
              messageDialog.open()
            }
          }
        }
      }//ColumnLayout
    }//ScrollView
  }//Rectangle

}
