// Qt Files
#include <QtCore/QCoreApplication>
// TaskAPI
#include "src/MyApi.h"

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);
    MyApi api;

    api.start(8082);

    return app.exec();
}
