import QtQuick 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12

MessageDialog {
    title: "알림"
    text: "등록하시겠습니까?"
    contentItem:
        Rectangle
        {
          width: parent.width
          height: parent.height
          color: Material.color(Material.Grey, Material.Shade800)
         }


    // 버튼 클릭 시 메시지 다이얼로그 닫기
    onAccepted: {
    }

    onRejected: {
    }
}
