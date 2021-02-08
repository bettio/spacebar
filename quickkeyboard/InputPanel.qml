import QtQuick 2.0
import "."
import Hemera.Spacebar 1.0

/**
 * This is the QML input panel that provides the virtual keyboard UI
 * The code has been derived from
 * http://tolszak-dev.blogspot.de/2013/04/qplatforminputcontext-and-virtual.html
 * Copyright 2015 Uwe Kindler
 * Licensed under MIT see LICENSE.MIT in project root
 */
Item {
    id:root

    property color backgroundColor: "black";
    property color keyButtonColor: "#35322f";
    property color specialKeyButtonColor: "#1e1b18";
    property font keyFont;
    property int verticalSpacing: keyboard.height / 40
    property int horizontalSpacing: verticalSpacing

    property string keymap: "default"

    objectName: "inputPanel"
    width: parent.width
    height: width / 4
    // Report actual keyboard rectangle to input engine
    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    signal keyboardButtonPressed();

    Loader {
        id: keyModel

        asynchronous: true
        source: "KeyModel_" + keymap + ".qml"
    }

    QtObject {
        id:pimpl

        property bool shiftModifier: false
        property bool symbolModifier: false
        property bool expandedAlphaModifier: false

        property int rowHeight: keyboard.height/4 - verticalSpacing
        property int buttonWidth:  (keyboard.width-column.anchors.margins)/10 - horizontalSpacing

        function imageUrl(elementName)
        {
            return "images/" + elementName + "_lightgrey.png";
        }
    }

    /**
     * The delegate that paints the key buttons
     */
    Component {
        id: keyButtonDelegate
        KeyButton {
            id: button

            color: keyButtonColor;
            font: keyFont;

            width: pimpl.buttonWidth
            height: pimpl.rowHeight
            text: buttonText(pimpl.shiftModifier, pimpl.symbolModifier, pimpl.expandedAlphaModifier);
            inputPanel: root

            onReleased: root.keyboardButtonPressed();

            function buttonText(shift, symbol, expandedAlpha) {
                if (shift) {
                    if (expandedAlpha) {
                        return expLetter.toUpperCase();
                    } else if (symbol) {
                        return secondSymbol;
                    } else {
                        return letter.toUpperCase();
                    }
                } else {
                    if (expandedAlpha) {
                        return expLetter;
                    } else if (symbol) {
                        return firstSymbol;
                    } else {
                        return letter;
                    }
                }
            }
        }
    }

    Connections {
        target: InputEngine
        // Switch the keyboard layout to Numeric if the input mode of the InputEngine changes
        onInputModeChanged: {
            pimpl.symbolModifier = ((InputEngine.inputMode == InputEngine.Numeric)
                                 || (InputEngine.inputMode == InputEngine.Dialable))
            if (pimpl.symbolModifier) {
                pimpl.shiftModifier = false
            }
        }
    }

    /**
     * This function shows the character preview popup for each key button
     */
    function showKeyPopup(keyButton)
    {
        keyPopup.popup(keyButton, root);
    }

    /**
     * The key popup for character preview
     */
    KeyPopup {
        id: keyPopup
        visible: false
        z: 100
    }


    Rectangle {
        id: keyboard;

        color: backgroundColor;

        anchors.fill: parent;

        MouseArea {
            anchors.fill: parent;
        }

        Column {
            id:column
            anchors.margins: 5
            anchors.fill: parent
            spacing: root.verticalSpacing

            Row {
                height: pimpl.rowHeight
                spacing: root.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    model: (keyModel.status == Loader.Ready) ? keyModel.item.firstRowModel : null
                    delegate: keyButtonDelegate
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: root.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                Repeater {
                    model: (keyModel.status == Loader.Ready) ? keyModel.item.secondRowModel : null
                    delegate: keyButtonDelegate
                }
            }
            Item {
                height: pimpl.rowHeight
                width:parent.width
                KeyButton {
                    id: shiftKey

                    color: (pimpl.shiftModifier)? "#1e6fa7": root.specialKeyButtonColor
                    font: keyFont

                    anchors.left: parent.left
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: ""
                    functionKey: true
                    onClicked: {
                        pimpl.shiftModifier = !pimpl.shiftModifier
                    }
                    onReleased: root.keyboardButtonPressed();

                    inputPanel: root

                    Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("shift");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.8;
                    }
                }
                Row {
                    height: pimpl.rowHeight
                    spacing: root.horizontalSpacing
                    anchors.horizontalCenter:parent.horizontalCenter
                    Repeater {
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: (keyModel.status == Loader.Ready) ? keyModel.item.thirdRowModel : null
                        delegate: keyButtonDelegate
                    }
                }
                KeyButton {
                    id: backspaceKey

                    color: root.specialKeyButtonColor
                    font: keyFont

                    anchors.right: parent.right
                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: "\x7F"
                    displayText: ""
                    inputPanel: root
                    repeat: true

                    Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("backspace");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.8;
                    }

                    onReleased: root.keyboardButtonPressed();
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: root.horizontalSpacing
                anchors.horizontalCenter:parent.horizontalCenter
                KeyButton {
                    id: hideKey

                    color: root.specialKeyButtonColor
                    font: keyFont

                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: ""
                    functionKey: true
                    onClicked: {
                        Qt.inputMethod.hide()
                    }
                    inputPanel: root
                    showPreview: false

                    Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("close");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.8;
                    }

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    color: root.specialKeyButtonColor
                    font: keyFont

                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: ""
                    inputPanel: root
                    functionKey: true
                    onClicked: {
                        pimpl.expandedAlphaModifier = !pimpl.expandedAlphaModifier
                    }

                   Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("expletters");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.8;
                    }

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    color: root.keyButtonColor
                    font: keyFont

                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: ","
                    inputPanel: root

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    id: spaceKey

                    color: root.keyButtonColor
                    font: keyFont

                    width: 3*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: " "
                    inputPanel: root
                    showPreview: false

                    Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("space");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.6;
                    }

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    color: root.keyButtonColor
                    font: keyFont

                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: "."
                    inputPanel: root

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    id: symbolKey

                    color: root.specialKeyButtonColor
                    font: keyFont

                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    text: (!pimpl.symbolModifier) ? "12#" : "ABC"
                    functionKey: true
                    onClicked: {
                        pimpl.symbolModifier = !pimpl.symbolModifier
                    }
                    inputPanel: root

                    onReleased: root.keyboardButtonPressed();
                }
                KeyButton {
                    id: enterKey

                    color: root.specialKeyButtonColor
                    font: keyFont

                    width: 1.25*pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayText: ""
                    text: "\n"
                    inputPanel: root

                    Image {
                        anchors.centerIn: parent;
                        cache: true;
                        source: pimpl.imageUrl("enter");
                        smooth: true;
                        fillMode: Image.PreserveAspectFit;
                        width: parent.width * 0.8;
                    }

                    onReleased: root.keyboardButtonPressed();
                }
            }
        }
    }
}
