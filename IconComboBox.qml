import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt.labs.folderlistmodel 2.4
import comboboxtests 1.0

ComboBox {
    id: comboBox

    property string iconSourceRole

    delegate: ItemDelegate {
        height: 64
        anchors.left: parent.left
        anchors.right: parent.right
        contentItem: IconChooserDelegateLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            text: model[comboBox.textRole]
            iconSource: model[comboBox.iconSourceRole]
        }
    }
    contentItem: IconChooserDelegateLayout {
        text: comboBox.displayText
        isInsideMaterialComboBox: true
        iconSource: {
//            console.log("QAbstractListModel", model instanceof QAbstractListModel);
//            console.log("QAbstractItemModel", model instanceof QAbstractItemModel);
//            console.log("FolderListModel", model instanceof FolderListModel);
//            console.log("DeviceTypesModel", model instanceof CppDefinedModel);
//            console.log("QtObject", model instanceof QtObject);

            if (comboBox.currentIndex < 0)
                return '';
            if (!comboBox.model)
                return '';
            if (!comboBox.iconSourceRole)
                return '';

            // FolderListModel has a different API
            if (model instanceof FolderListModel)
                return model.get(comboBox.currentIndex, iconSourceRole);
            // ListModel has another different API
            else if ('get' in model)
            {
                const data = model.get(comboBox.currentIndex);
                console.log(data);
                return data[iconSourceRole];
            }
            // and I dont know how to access C++ models from QML at all
            else if ('roleNames' in model || 'data' in model)
            {
                if (!('roleNames' in model && 'data' in model))
                    throw 'roleNames or data not defined!';

                const roleNames = model.roleNames();
                console.log('roleNames', roleNames);

                const index = model.index(comboBox.currentIndex, 0);
                const data = model.data(index, 99);
                console.log('data', data);

                throw 'getting data from model using roleNames and data is not yet implemented.';
            }
            else
                throw 'unknown model type: ' + typeof model;
        }
    }
}
