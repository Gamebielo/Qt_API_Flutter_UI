#include "MyApi.h"

MyApi::MyApi(QObject* parent) : QObject(parent)
{
    server = new QTcpServer(this);
    QObject::connect(server, &QTcpServer::newConnection, this, &MyApi::newConnection);
}

MyApi::~MyApi()
{
}

void MyApi::start(int port)
{
    if (!server->listen(QHostAddress::Any, port)) {
        qDebug() << "Failed to start server.";
        return;
    }
    qDebug() << "Server started on port" << port;
}

void MyApi::readData()
{
    QTcpSocket* clientSocket = qobject_cast<QTcpSocket*>(sender());
    if (!clientSocket)
        return;

    QByteArray requestData = clientSocket->readAll();
    qDebug() << "Request received:" << requestData;

    QString response;
    if (requestData.startsWith("GET /hello")) {
        response = "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/plain\r\n"
            "\r\n"
            "Hello from Qt C++ API!";
    }
    else if (requestData.startsWith("GET /bye")) {
        response = "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/plain\r\n"
            "\r\n"
            "Goodbye from Qt C++ API!";
    }
    else {
        response = "HTTP/1.1 404 Not Found\r\n"
            "Content-Type: text/plain\r\n"
            "\r\n"
            "Endpoint not found";
    }

    clientSocket->write(response.toUtf8());
    clientSocket->flush();
    clientSocket->waitForBytesWritten();
    clientSocket->close();
}

void MyApi::newConnection()
{
    QTcpSocket* clientSocket = server->nextPendingConnection();
    connect(clientSocket, &QTcpSocket::readyRead, this, &MyApi::readData);
    connect(clientSocket, &QTcpSocket::disconnected, clientSocket, &QTcpSocket::deleteLater);
}