import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import Qt.labs.folderlistmodel 2.4
import comboboxtests 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    GridLayout {
        anchors.fill: parent

        columns: 2

        // IconComboBox shall support qml ListModels
        IconComboBox {
            Layout.preferredHeight: 64
            id: listModelComboBox
            textRole: 'theText'
            valueRole: 'theValue'
            iconSourceRole: 'theIconUrl'
            model: ListModel {
                ListElement { theText: 'text0'; theValue: 'value0'; theIconUrl: 'qrc:/comboboxtests/icons/movinghead.png' }
                ListElement { theText: 'text1'; theValue: 'value1'; theIconUrl: 'qrc:/comboboxtests/icons/movinghead.png' }
                ListElement { theText: 'text2'; theValue: 'value2'; theIconUrl: 'qrc:/comboboxtests/icons/nebelmaschine.png' }
                ListElement { theText: 'text3'; theValue: 'value3'; theIconUrl: 'qrc:/comboboxtests/icons/nebelmaschine.png' }
                ListElement { theText: 'text4'; theValue: 'value4'; theIconUrl: 'qrc:/comboboxtests/icons/rgbstrahler.png' }
                ListElement { theText: 'text5'; theValue: 'value5'; theIconUrl: 'qrc:/comboboxtests/icons/rgbstrahler.png' }
            }
        }
        Label {
            text: qsTr('currentValue: ') + listModelComboBox.currentValue
        }

        // IconComboBox shall support qml FolderListModels (to let the user select which icon to use)
        IconComboBox {
            Layout.preferredHeight: 64
            id: folderListModelComboBox
            textRole: "fileBaseName"
            valueRole: "fileBaseName"
            iconSourceRole: "fileUrl"
            model: FolderListModel {
                folder: "qrc:/comboboxtests/icons/"
                showDirs: false

                function getUrlForIcon(name) {
                    let myFolder = folder;
                    if (myFolder.length < 1 || myFolder.charAt(myFolder.length - 1) !== '/') {
                        myFolder = myFolder + '/';
                    }

                    return myFolder + name + ".png"
                }
            }
        }
        Label {
            text: qsTr('currentValue: ') + folderListModelComboBox.currentValue
        }

        // IconComboBox shall support C++ QAbstractListModels (access to our internal database)
        IconComboBox {
            Layout.preferredHeight: 64
            id: cppModelComboBox
            textRole: 'theText'
            valueRole: 'theValue'
            iconSourceRole: 'theIconUrl'
            model: CppDefinedModel {

            }
        }
        Label {
            text: qsTr('currentValue: ') + cppModelComboBox.currentValue
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
