from PySide6.QtGui import *
from PySide6.QtQml import *
from PySide6.QtQuick import *
from PySide6.QtCore import *
import os
class UniDeskTools(QQuickItem):
    def __init__(self):
        super().__init__()

    @Slot(QColor,QColor,QColor,QColor,bool,bool,bool,result=QColor)
    def switchColor(self,normal,hover,press,disable,hovered,pressed,disabled):
        if disabled:
            return disable
        elif pressed:
            return press
        elif hovered:
            return hover
        else:
            return normal
    
    @Slot(str)
    def systemCommand(self,command):
        os.system(command)
        
    @Slot(str,int,result=QFont)
    def font(self,family,size):
        f=QFont()
        f.setFamily(family)
        f.setPixelSize(size)
        return f

