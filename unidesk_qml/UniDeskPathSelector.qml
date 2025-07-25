import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Basic
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import unidesk_qml
import org.itcdt.unidesk

Item{
    id: root
    property url path
    //0: File,1: Folder
    property int mode: 0
    signal submit
    width: row_layout.width
    height: row_layout.height
    RowLayout{
        id: row_layout
        anchors.fill: parent
        spacing: 10
        UniDeskTextField{
            id: path_textfield
            text: root.path.toString().slice(8)
            Layout.fillWidth: true
            placeholderText: qsTr("输入路径（按回车确认）")
            onEditingFinished: {
                root.submit();
            }
            onTextEdited: {
                root.path=UniDeskTools.fromLocalFile(text)
            }
        }
        UniDeskButton{
            display: Button.TextOnly
            contentText: qsTr("浏览..")
            bgHoverColor: UniDeskGlobals.isLight ? Qt.rgba(1,1,1,0.5).darker(1.2) : Qt.rgba(0,0,0,0.5).lighter(1.2)
            bgPressColor: UniDeskGlobals.isLight ? Qt.rgba(1,1,1,0.5).darker(1.5) : Qt.rgba(0,0,0,0.5).lighter(1.5)
            borderWidth: 1
            radius: 5
            onClicked: {
                if(root.mode===0){
                    file_dialog.open();
                }
                else{
                    folder_dialog.open();
                }
            }
        }
    }
    FileDialog{
        id: file_dialog
        fileMode: FileDialog.OpenFile
        acceptLabel: qsTr("选定")
        rejectLabel: qsTr("取消")
        title: qsTr("选择文件")
        onAccepted:{
            root.path=selectedFile
            root.submit()
        }
    }
    FolderDialog{
        id: folder_dialog
        acceptLabel: qsTr("选定")
        rejectLabel: qsTr("取消")
        title: qsTr("选择路径")
        onAccepted:{
            root.path=selectedFolder
            root.submit();
        }
    }
    
}