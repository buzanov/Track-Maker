import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.Portrait

    SilicaListView {
           anchors.fill: parent
           header: PageHeader { title: qsTr("Журнал пробежек") }
           model: jmodel
           delegate: journalD
    }
       Component {
           id: journalD

           ListItem {
               id: journalItem
               contentHeight: Theme.itemSizeMedium

               function remove() {
                   jmodel.removeNote(model.index);
               }

               menu: ContextMenu {
                   MenuItem {
                       text: qsTr("Delete")
                       onClicked: journalItem.remove()
                   }
               }

               onClicked: {
                   var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/NoteDialog.qml"), {
                                                   date: jmodel.getDate(),
                                                   coords: jmodel.getCoords(),
                                                   time: jmodel.getTime()
                                               });
               }

               ListView.onRemove: journalItem.animateRemoval()

               Column {
                   anchors {
                       left: parent.left
                       right: parent.right
                       margins: Theme.horizontalPageMargin
                       verticalCenter: parent.verticalCenter
                   }

                   Label {
                       text: model.date
                       color: journalItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                       width: parent.width
                   }

                   Label {
                       text: model.time
                       color: journalItem.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                       font.pixelSize: Theme.fontSizeSmall
                       width: parent.width
                   }
               }
           }
       }
}
