#include "myquickitem.h"
#include "mypainteditem.h"

MyQuickItem::MyQuickItem(QQuickItem *parent)
    : QQuickItem(parent)
{
    connect(this, &QQuickItem::widthChanged, this, &MyQuickItem::onSizeChanged);
    connect(this, &QQuickItem::heightChanged, this, &MyQuickItem::onSizeChanged);
    createCanvases();
}

void MyQuickItem::createCanvases()
{
    for (int i = 0; i < 3; ++i) {
        m_canvases[i] = new MyPaintedItem(this);
    }
}

void MyQuickItem::onSizeChanged()
{
    for (int i = 0; i < 3; ++i) {
        m_canvases[i]->setSize(QSizeF(int(width()),int(height())));
    }
}
