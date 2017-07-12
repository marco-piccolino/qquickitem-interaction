#include "mypainteditem.h"

MyPaintedItem::MyPaintedItem(QQuickItem *parent)
    :QQuickPaintedItem(parent)
{
    setFillColor(QColor("#eee"));
}

void MyPaintedItem::paint(QPainter *painter)
{
    qDebug() << "paint";
}
