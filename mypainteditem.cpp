#include "mypainteditem.h"

MyPaintedItem::MyPaintedItem(QQuickItem *parent)
    :QQuickPaintedItem(parent)
{
    setFillColor(QColor(qrand() % 255,qrand() % 255,qrand() % 255));
}

void MyPaintedItem::paint(QPainter *painter)
{

}
