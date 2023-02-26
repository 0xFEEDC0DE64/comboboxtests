import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

RowLayout {
    property string text
    property string iconSource
    property bool isInsideMaterialComboBox: false

    id: layout

    Image {
        Layout.topMargin: isInsideMaterialComboBox ? 15 : 9
        Layout.bottomMargin: isInsideMaterialComboBox ? 15 : 9
        Layout.fillHeight: true
        source: layout.iconSource
        fillMode: Image.PreserveAspectFit
    }
    Label {
        Layout.preferredHeight: layout.height
        text: layout.text
        verticalAlignment: Label.AlignVCenter
        fontSizeMode: Text.VerticalFit
        font.pixelSize: 20
    }
    Item {
        Layout.fillWidth: true
    }
}
