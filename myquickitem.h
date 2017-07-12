#ifndef MYQUICKITEM_H
#define MYQUICKITEM_H

#include <QQuickItem>

class MyQuickItem : public QQuickItem
{
    Q_OBJECT
public:
    MyQuickItem();
private:
    void createCanvases();
};

#endif // MYQUICKITEM_H
