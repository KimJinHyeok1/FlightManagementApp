import QtQuick 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.15

MessageDialog {
    id: messageDialog
    title: "Alert"
    text: "등록하시겠습니까?"

    // 버튼 클릭 시 메시지 다이얼로그 닫기
    onAccepted: {
        console.log("OK 버튼이 클릭되었습니다.");
    }

    onRejected: {
        console.log("취소 버튼이 클릭되었습니다.");
    }
}
