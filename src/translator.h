#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QGuiApplication>
#include <QQuickView>
#include <QTranslator>
#include "languages.h"

class Translator:public QObject{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)
public:
    Translator(QGuiApplication *app,int lang){
        mApp=app;
        updateLanguage(lang);
    }
    QString getEmptyString(){return "";}
signals:
    void languageChanged();
public slots:
    void updateLanguage(int lang){
        switch (lang) {
        case Languages::ENG:
            mTranslator.load("Medical_EN",":/translation");
            mApp->installTranslator(&mTranslator);
            lng = Languages::ENG;
            break;
        case Languages::AR:
            mTranslator.load("Medical_AR",":/translation");
            mApp->installTranslator(&mTranslator);
            lng = Languages::AR;
            break;
        default:
            mApp->removeTranslator(&mTranslator);
            lng = Languages::FA;
            break;
        }
        emit languageChanged();
    }
    int getCurrentLanguage(){
        return lng;
    }
private:
    QGuiApplication * mApp;
    QTranslator mTranslator;
    int lng = Languages::FA;
};
#endif // TRANSLATOR_H
