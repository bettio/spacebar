import QtQuick 2.0
import Hemera.Spacebar 1.0

/**
 * This is the type implements one single key button in the InputPanel
 * The code has been derived from
 * http://tolszak-dev.blogspot.de/2013/04/qplatforminputcontext-and-virtual.html
 * Copyright 2015 Uwe Kindler
 * Licensed under MIT see LICENSE.MIT in project root
 */
Item {
    id:keyButton
    /**
     * The background color of this button
     */
    property color color: "#35322f"

    /**
     * The key text to show in this button
     */
    property string text

    /**
     * The font for rendering of text
     */
    property alias font: txt.font

    /**
     * The color of the text in this button
     */
    property alias textColor: txt.color

    /**
     * This property holds the pressed status of the key.
     */
    property alias isPressed: buttonMouseArea.pressed

    /**
     * This property holds a reference to the input panel.
     * A key can only show the charcter preview popup if this property contains
     * a valid refernce to the input panel
     */
    property var inputPanel

    /**
     * This property holds the highlighted status of the key
     * The highlighted status is a little bit different from the pressed status
     * If the user releases the key, it is not pressed anymore, but it is still
     * highlighted for some milliseconds
     */
    property bool isHighlighted: false

    /**
     * Sets the show preview attribute for the character preview key popup
     */
    property bool showPreview: true

    /**
     * Sets the key repeat attribute.
     * If the repeat is enabled, the key will repeat the input events while held down.
     * The default is false.
     */
    property bool repeat: false

    /**
     * Sets the key code for input method processing.
     */
    property int key

    /**
     * Sets the display text - this string is rendered in the keyboard layout.
     * The default value is the key text.
     */
    property alias displayText: txt.text

    /**
     * Sets the function key attribute.
     */
    property bool functionKey: false

    signal clicked()
    signal pressed()
    signal released()

    Rectangle {
        anchors.fill: parent
        radius: ((root.verticalSpacing != 0) && (root.horizontalSpacing != 0)) ? (height / 30) : 0
        color: isHighlighted ? Qt.tint(keyButton.color, "#801e6fa7") : keyButton.color
        Text {
            id: txt
            color: "white"
            anchors.margins: Math.round(parent.width / 8)
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: keyButton.text
        }
        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: keyButton.clicked()
            onPressed: keyButton.pressed()
            onReleased: keyButton.released()
        }
    }

    Timer {
        id: highlightTimer
        interval: 100
        running: !isPressed
        repeat: false

        onTriggered: {
            isHighlighted = false;
        }
    }

    Timer {
        id: repeatTimer
        interval: 500
        repeat: true
        running: keyButton.repeat && keyButton.isPressed

        onTriggered: {
            if (keyButton.state == "")
            {
                keyButton.state = "REPEATING"
                console.log("switching to repeating");
            }
            else if (keyButton.state == "REPEATING")
            {
                console.log("repeating");
            }

            if (!functionKey)
            {
                InputEngine.sendKeyToFocusItem(text)
            }
        }
    }

    onInputPanelChanged: {
        console.log("onInputPanelChanged: " + inputPanel.objectName);
    }

    /**
     * If the InputPanel property has a valid InputPanel reference and if
     * showPreview is true, then this function calls showKeyPopup() to
     * show the character preview popup.
     */
    onPressed: {
        if (inputPanel != null && showPreview)
        {
            inputPanel.showKeyPopup(keyButton);
        }
        isHighlighted = true;
    }

    onReleased: {
        state = ""
        console.log("onReleased - functionKey = " + functionKey)
        if (!functionKey)
        {
            InputEngine.sendKeyToFocusItem(text)
        }
    }

    states: [
        State {
            name: "REPEATING"
            PropertyChanges { target: repeatTimer; interval: 50}
        }
    ]
}
