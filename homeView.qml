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
            TextField{
              Layout.preferredWidth: parent.width
              Layout.preferredHeight: parent.height * 0.8
            }
            Button{
              text : "메시지 보내기"
              Layout.preferredWidth: parent.width
            }
          }
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
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/drone.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                  }
                }
              }
              Rectangle{
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/battery-status-full.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                  }
                }
              }//Pane
            }//rowLayout_1
            RowLayout{
              Layout.preferredWidth : iconColumnLayout.width
              Layout.preferredHeight: iconColumnLayout.height
              Rectangle{
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/user.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
                  }
                }
              }
              Rectangle{
                Layout.preferredWidth : parent.width * 0.5
                Layout.preferredHeight : parent.height
                Image{
                  source : "./icon/folder.png"
                  anchors.centerIn: parent
                  sourceSize.width: parent.width * 0.85
                  sourceSize.height: parent.height * 0.85
                  MouseArea{
                    anchors.fill : parent
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
