import QtQuick 2.10
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
Item {
    Rectangle{
        id : homeViewRec
        anchors.fill: parent
        color: Material.color(Material.Grey, Material.Shade800)
      ColumnLayout{
        anchors.fill : parent
        Pane{
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: parent.height * 0.15
          Image{
            id : vesselImage
            anchors.centerIn: parent
            width : parent.width * 0.8
            height : parent.height
            source : "./icon/vessel.png"
          }
        }
        Pane{
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: parent.height * 0.4
          ColumnLayout{
          anchors.fill: parent

            Label{
              text : "Description"
              font.pointSize: 15
              font.bold : true
              color: "orange"
            }
            Label{
              text : "기체 등록 탭 : 사용 기체(드론) 조회 및 등록 tab"
            }
            Label{
              text : "배터리 등록 탭 : 사용 배터리 조회 및 등록 tab"
            }
            Label{
              text : "운용자 등록 탭 : 운용자(EP,IP) 조회 및 등록 tab"
            }
            Label{
              text : "비행 데이터 탭 : 비행 데이터(드론 비행계획) 등록 tab"
            }
            Label{
              text : "비행이력 검색 탭 : 등록 비행 데이터 조건 조회 및 요약정보 표출 tab"
            }
            Label{
              font.pointSize: 12
              font.bold : true
              color: "orange"
              text : "config.json에서 각종 사전 정의값(자격증, 비행장소 등..) \n및 서버주소 설정가능"
            }
            Label{
              text : "S/W Version : Flight Log Application ver 1.0.0"
            }
          }
        }
        Label
        {
          id : batteryType
          text : " 바로가기"
          Layout.topMargin: 15
          font.pointSize: 15
          font.bold : true
          color: "orange"
        }
        Pane{
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: parent.height * 0.4
          ColumnLayout{
            id : iconColumnLayout
            anchors.fill: parent
            RowLayout{
              Layout.preferredWidth : iconColumnLayout.width
              Layout.preferredHeight: iconColumnLayout.height
              Rectangle{
                color: Material.color(Material.Grey, Material.Shade700)
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/drone.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                    onClicked: stackView.replace("qrc:/aircraftRegisterView.qml");
                  }
                }
              }
              Rectangle{
                color: Material.color(Material.Grey, Material.Shade700)
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/battery-status-full.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                    onClicked: stackView.replace("qrc:/batteryRegisterView.qml");
                  }
                }
              }//Pane
            }//rowLayout_1
            RowLayout{
              Layout.preferredWidth : iconColumnLayout.width
              Layout.preferredHeight: iconColumnLayout.height
              Rectangle{
                color: Material.color(Material.Grey, Material.Shade700)
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/user.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                    onClicked: stackView.replace("qrc:/operatorRegisterView.qml");
                  }
                }
              }
              Rectangle{
                color: Material.color(Material.Grey, Material.Shade700)
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/folder.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                    onClicked: stackView.replace("qrc:/flightDataRegisterView.qml");
                  }
                }
              }//Pane
            }//rowLayout_1
          }//ColumnLayout
        }
        Label
        {
          Layout.preferredWidth: parent.width
          text : " ver. 1.0.0"
          font.pointSize: 20
          font.bold : true
          color: "white"
        }
      }
    }//Rectangle
  }//Item

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
