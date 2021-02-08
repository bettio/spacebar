import QtQuick 2.0

Item {
    property QtObject firstRowModel: first
    property QtObject secondRowModel: second
    property QtObject thirdRowModel: third


    ListModel {
        id:first
        ListElement { letter: "q"; firstSymbol: "1"; secondSymbol: "1"; expLetter: "à" }
        ListElement { letter: "w"; firstSymbol: "2"; secondSymbol: "2"; expLetter: "á" }
        ListElement { letter: "e"; firstSymbol: "3"; secondSymbol: "3"; expLetter: "ę" }
        ListElement { letter: "r"; firstSymbol: "4"; secondSymbol: "4"; expLetter: "ť" }
        ListElement { letter: "t"; firstSymbol: "5"; secondSymbol: "5"; expLetter: "š" }
        ListElement { letter: "z"; firstSymbol: "6"; secondSymbol: "6"; expLetter: "ř" }
        ListElement { letter: "u"; firstSymbol: "7"; secondSymbol: "7"; expLetter: "š" }
        ListElement { letter: "i"; firstSymbol: "8"; secondSymbol: "8"; expLetter: "ň" }
        ListElement { letter: "o"; firstSymbol: "9"; secondSymbol: "9"; expLetter: "ó" }
        ListElement { letter: "p"; firstSymbol: "0"; secondSymbol: "0"; expLetter: "ú" }
    }
    ListModel {
        id:second
        ListElement { letter: "a"; firstSymbol: "!"; secondSymbol: "|"; expLetter: "ą" }
        ListElement { letter: "s"; firstSymbol: "@"; secondSymbol: "^"; expLetter: "ś" }
        ListElement { letter: "d"; firstSymbol: "#"; secondSymbol: "<"; expLetter: "ě" }
        ListElement { letter: "f"; firstSymbol: "$"; secondSymbol: ">"; expLetter: "é" }
        ListElement { letter: "g"; firstSymbol: "%"; secondSymbol: "{"; expLetter: "ì" }
        ListElement { letter: "h"; firstSymbol: "&"; secondSymbol: "}"; expLetter: "í" }
        ListElement { letter: "j"; firstSymbol: "*"; secondSymbol: "["; expLetter: "î" }
        ListElement { letter: "k"; firstSymbol: "?"; secondSymbol: "]"; expLetter: "ï" }
        ListElement { letter: "l"; firstSymbol: "/"; secondSymbol: "="; expLetter: "ł" }
    }
    ListModel {
        id:third
        ListElement { letter: "y"; firstSymbol: "_"; secondSymbol: "\\"; expLetter: "õ" }
        ListElement { letter: "x"; firstSymbol: "\""; secondSymbol: ":"; expLetter: "ö" }
        ListElement { letter: "c"; firstSymbol: "'"; secondSymbol: ";"; expLetter: "ő" }
        ListElement { letter: "v"; firstSymbol: "("; secondSymbol: "`"; expLetter: "ź" }
        ListElement { letter: "b"; firstSymbol: ")"; secondSymbol: "°"; expLetter: "č" }
        ListElement { letter: "n"; firstSymbol: "-"; secondSymbol: "~"; expLetter: "ű" }
        ListElement { letter: "m"; firstSymbol: "+"; secondSymbol: "€"; expLetter: "ü" }
    }
}
