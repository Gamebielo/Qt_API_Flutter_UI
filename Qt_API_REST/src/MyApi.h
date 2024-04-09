#pragma once
#include "QDebug"
#include "QObject"
#include "QtWebSockets"
#include "QJsonDocument"
#include "QJsonObject"
#include "QJsonArray"

class MyApi : public QObject {
    Q_OBJECT
public:
    explicit MyApi(QObject* parent = nullptr);
    ~MyApi();

    void start(int port);

private slots:
    void newConnection();
    void readData();

private:
    QTcpServer* server;
};
