import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Basic
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import unidesk_qml
import org.itcdt.unidesk

Item {
    id: control
    property color tintColor: Qt.rgba(1, 1, 1, 1)
    property real tintOpacity: 0.65
    property real luminosity: 0.01
    property real noiseOpacity: 0.02
    property var target
    property int blurRadius: 32
    property rect targetRect: Qt.rect(control.x, control.y, control.width, control.height)
    
    property int cornerRadius: 5

    Rectangle { 
        id: roundedBackground
        anchors.fill: parent
        radius: control.cornerRadius
        clip: true 
        color: "transparent" 

        ShaderEffectSource {
            id: effect_source
            anchors.fill: parent
            visible: false
            sourceRect: control.targetRect
            sourceItem: control.target
        }

        Rectangle{
            anchors.fill: parent
            radius: control.cornerRadius
            clip: true
            FastBlur {
                id: fast_blur
                anchors.fill: parent
                source: effect_source
                radius: control.blurRadius
            }
        
        }

        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(1, 1, 1, luminosity)
            radius: parent.radius 
        }
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(tintColor.r, tintColor.g, tintColor.b, tintOpacity)
            radius: parent.radius 
        }
        Image {
            id: noise_image
            anchors.fill: parent
            source: "qrc:/media/img/noise.png"
            fillMode: Image.Tile
            opacity: control.noiseOpacity
        }
    }
}
