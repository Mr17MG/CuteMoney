#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/qcustomdate.h"
#include "src/qdateconvertor.h"
#include "src/languages.h"
#include "src/translator.h"
#include <QSettings>
#include "statusbar.h"
#include <QQuickStyle> // Require For setStyle()

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(QString(":/Icons/icon.png")));
    app.setOrganizationDomain("mrmg");
    app.setApplicationName("ir.mrmg.CuteMoney");
    app.setApplicationVersion("1.0.0");
    qmlRegisterType<StatusBar>("StatusBar", 1, 0, "StatusBar");
    qmlRegisterType<QDateConvertor>("ir.myco.date", 1, 0, "DateConvertor");
    qmlRegisterType<QCustomDate>("ir.myco.date", 1 ,0, "CustomDate");
    qmlRegisterType<Languages>("ir.myco.Languages",1,0,"MycoLanguages");

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");

    QSettings settings(QGuiApplication::organizationDomain(), QGuiApplication::applicationName());
    Translator mTrans(&app,Languages::FA);
    if(settings.value("Language","")=="")
    {
        settings.setValue("Language",Languages::FA);
    }
    else {
        mTrans.updateLanguage((settings.value("Language",Languages::FA).toInt()));
    }

    engine.rootContext()->setContextProperty("mytrans",(QObject *)&mTrans);

    engine.load(QUrl(QStringLiteral("qrc:/Pages/BasePages/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
