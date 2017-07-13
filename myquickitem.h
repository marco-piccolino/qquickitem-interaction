#ifndef MYQUICKITEM_H
#define MYQUICKITEM_H

#include <QQuickItem>

#include "mypainteditem.h"

class MyQuickItem : public QQuickItem
{
    Q_OBJECT
public:
    MyQuickItem(QQuickItem* parent = nullptr);
    Q_INVOKABLE void createCanvases();
public slots:
    void onSizeChanged();
private:
    MyPaintedItem* m_canvases[3];
};

#endif // MYQUICKITEM_H
