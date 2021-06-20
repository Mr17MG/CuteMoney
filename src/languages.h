#ifndef LANGUAGES_H
#define LANGUAGES_H
#include <QObject>
#include <QLocale>

class Languages:public QObject{
    Q_OBJECT
public:
    Languages(){};
    enum E_Languages{
        ENG = QLocale::English,
        FA = QLocale::Persian,
        AR = QLocale::Arabic
    };
    Q_ENUM(E_Languages)
};
#endif // LANGUAGES_H
