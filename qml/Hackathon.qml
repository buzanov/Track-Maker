import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "model"
import QtLocation 5.0
import QtPositioning 5.0

ApplicationWindow
{
    readonly property JournalModel jmodel: JournalModel {}

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
