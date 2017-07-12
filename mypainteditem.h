#ifndef MYPAINTEDITEM_H
#define MYPAINTEDITEM_H

#include <QQuickPaintedItem>

class MyPaintedItem : public QQuickPaintedItem
{
    Q_OBJECT
public:
    MyPaintedItem(QQuickItem *parent = 0);
    void paint(QPainter *painter);

signals:

public slots:
};

#endif // MYPAINTEDITEM_H
