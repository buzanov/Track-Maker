#include <QtQuick>
#include <QObject>
#include <QFile>
#include <sailfishapp.h>
#include <qallificationrun.h>
#include <user.h>
#include <track.h>
#include <quallrunthread.h>

#define FILE_NAME "userLog.txt"

void fillUserLog(QFile *file){

    file->open(QIODevice::ReadWrite);
    file->write("3\n5\n10");
    file->close();
}

void buildUser(QFile *file, User *user){
    file->open(QIODevice::ReadOnly);
    user->updateWallk(file->readLine().toFloat());
    user->updateFastWallk(file->readLine().toFloat());
    user->updateRun(file->readLine().toFloat());
    file->close();
}

int main(int argc, char *argv[])
{    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
     QScopedPointer<QQuickView> view(SailfishApp::createView());
     view->setSource(SailfishApp::pathToMainQml());

    User *user = new User();

    QFile userLog(FILE_NAME);

    if( !(QFile::exists(FILE_NAME)))
        fillUserLog(&userLog);

    buildUser(&userLog, user);
    qualificationsRun *qualRun;
    qualRun = new qualificationsRun( user);
    Track *track = new Track();
    track->setupUser( user);

    QualRunThread *qrt = new QualRunThread (qualRun);

    view->rootContext()->setContextProperty("User", user);
    view->rootContext()->setContextProperty("QualRun", qualRun);
    view->rootContext()->setContextProperty("Track", track);
     view->rootContext()->setContextProperty("QualThread", qrt);

     view->show();




    return app->exec();//SailfishApp::main(argc, argv);
}
