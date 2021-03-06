/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

T.TextField {
    property color primaryTextColor: "#444"
    property color hintTextColor: "#444"
    property bool hasBottomBorder: true
    property color bottomBorderColor: "red"
    property bool bottomBorderColorChanged : false
    id: control
    color: textColor
    horizontalAlignment: Text.AlignHCenter
    bottomPadding: size1H*10
    font { family: styles.iransansBold.name; pixelSize: size1F*12 ;}
    placeholderText: ""
    Material.accent: styles.accentColor1
    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            placeholderText ? placeholder.implicitWidth + leftPadding + rightPadding : 0)
                            || contentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             background ? background.implicitHeight : 0,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    topPadding: 8
    //bottomPadding: 16

   // color: enabled ? Material.foreground : Material.hintTextColor
    selectionColor: Material.accentColor
    selectedTextColor: Material.primaryHighlightedTextColor
    selectByMouse: true
    verticalAlignment: TextInput.AlignVCenter
    cursorDelegate: CursorDelegate { }

    onTextChanged: {
        text = functions.faToEnNumber(text)
    }

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        font: control.font
        color: control.hintTextColor
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
        visible: !control.length && !control.preeditText && (!control.activeFocus) //|| control.horizontalAlignment !== Qt.AlignHCenter)

    }

    background: Rectangle {
        visible: hasBottomBorder
        y: control.height - height - control.bottomPadding + size1H*8
//        implicitWidth: 120
        width: parent.width
//        height: control.text???!=="" || control.activeFocus || control.hovered ?
//                    (control.text===""?size1H : size1H*2):size1H
        height: control.text === "" ?
                    control.activeFocus || control.hovered ? size1H*2:size1H
        :size1H*2
        color: bottomBorderColorChanged?bottomBorderColor:
                                         control.activeFocus ? control.Material.accentColor
                                   : (control.hovered ? control.Material.accentColor:
                                                        control.text???===""?control.hintTextColor:control.Material.accentColor)
    }
}

