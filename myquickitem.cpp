#include "myquickitem.h"
#include "mypainteditem.h"

MyQuickItem::MyQuickItem(QQuickItem *parent)
    : QQuickItem(parent)
{
    createCanvases();
}

void MyQuickItem::createCanvases()
{
    for (int i = 0; i < 3; ++i) {
        m_canvases[i] = new MyPaintedItem(this);
    }
}
