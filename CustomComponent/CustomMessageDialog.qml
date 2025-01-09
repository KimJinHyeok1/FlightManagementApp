import QtQuick 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
MessageDialog {

    id : messageDialog
    property var message: "등록하시겠습니까?"
    property bool isRegister : true
    property var dataType : ""
    property var isDelete : false
    property var currentIndex : 0

    title: "알림"
    contentItem:
        Rectangle
        {
          anchors.fill : parent
          color: Material.color(Material.Grey, Material.Shade800)
          ColumnLayout{
            anchors.fill: parent
            RowLayout{
              Layout.preferredWidth: parent.width
              Layout.topMargin: 5
              Label{
                Layout.alignment: Qt.AlignCenter
                Layout.leftMargin: 10
                color : "white"
                font.bold: true
                font.pointSize: 12
                text : messageDialog.message
              }
             }
            RowLayout{
              Layout.preferredWidth: parent.width
                Button{
                  Layout.alignment: Qt.AlignCenter
                  text : "확인"
                  onClicked:{
                    if(isDelete){
                      if (dataType == "aircraft")
                      {
                        listView_1.model = DataModel.aircraftModel
                        DataModel.deleteData(currentIndex, dataType);
                      }
                      else if (dataType == "battery"){
                        listView_1.model = DataModel.battryModel
                        DataModel.deleteData(currentIndex, dataType);
                      }
                      else{
                        listView_1.model = DataModel.operatorModel
                        DataModel.deleteData(currentIndex, dataType);
                      }
                    }

                    messageDialog.isRegister ? DataModel.createData(dataType)
                                             : DataModel.modifyData(dataType);
                    messageDialog.close()
                  }
                }
                Button{
                  Layout.alignment: Qt.AlignCenter
                  text : "취소"
                  onClicked: messageDialog.close()
                }
            }
          }
         }

    // 버튼 클릭 시 메시지 다이얼로그 닫기
}
