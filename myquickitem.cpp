#include "myquickitem.h"

MyQuickItem::MyQuickItem()
{
    setFlag(QQuickItem::ItemHasContents, false);
    setFlag(QQuickItem::ItemClipsChildrenToShape, true);
    createCanvases();
}

void MyQuickItem::createCanvases()
{

}
