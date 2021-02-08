import QtQuick 2.0

Item {
    property QtObject firstRowModel: first
    property QtObject secondRowModel: second
    property QtObject thirdRowModel: third


    ListModel {
        id:first
        ListElement { letter: "q"; firstSymbol: "1"; secondSymbol: "1"; expLetter: "à" }
        ListElement { letter: "w"; firstSymbol: "2"; secondSymbol: "2"; expLetter: "á" }
        ListElement { letter: "e"; firstSymbol: "3"; secondSymbol: "3"; expLetter: "ï" }
        ListElement { letter: "r"; firstSymbol: "4"; secondSymbol: "4"; expLetter: "ý" }
        ListElement { letter: "t"; firstSymbol: "5"; secondSymbol: "5"; expLetter: "ó" }
        ListElement { letter: "z"; firstSymbol: "6"; secondSymbol: "6"; expLetter: "ř" }
        ListElement { letter: "u"; firstSymbol: "7"; secondSymbol: "7"; expLetter: "š" }
        ListElement { letter: "i"; firstSymbol: "8"; secondSymbol: "8"; expLetter: "ň" }
        ListElement { letter: "o"; firstSymbol: "9"; secondSymbol: "9"; expLetter: "š" }
        ListElement { letter: "p"; firstSymbol: "0"; secondSymbol: "0"; expLetter: "đ" }
    }
    ListModel {
        id:second
        ListElement { letter: "a"; firstSymbol: "!"; secondSymbol: "|"; expLetter: "ą" }
        ListElement { letter: "s"; firstSymbol: "@"; secondSymbol: "^"; expLetter: "ś" }
        ListElement { letter: "d"; firstSymbol: "#"; secondSymbol: "<"; expLetter: "ě" }
        ListElement { letter: "f"; firstSymbol: "$"; secondSymbol: ">"; expLetter: "ë" }
        ListElement { letter: "g"; firstSymbol: "%"; secondSymbol: "{"; expLetter: "ì" }
        ListElement { letter: "h"; firstSymbol: "&"; secondSymbol: "}"; expLetter: "í" }
        ListElement { letter: "j"; firstSymbol: "*"; secondSymbol: "["; expLetter: "č" }
        ListElement { letter: "k"; firstSymbol: "?"; secondSymbol: "]"; expLetter: "ć" }
        ListElement { letter: "l"; firstSymbol: "/"; secondSymbol: "="; expLetter: "ž" }
    }
    ListModel {
        id:third
        ListElement { letter: "y"; firstSymbol: "_"; secondSymbol: "\\"; expLetter: "ł" }
        ListElement { letter: "x"; firstSymbol: "\""; secondSymbol: ":"; expLetter: "č" }
        ListElement { letter: "c"; firstSymbol: "'"; secondSymbol: ";"; expLetter: "õ" }
        ListElement { letter: "v"; firstSymbol: "("; secondSymbol: "`"; expLetter: "ď" }
        ListElement { letter: "b"; firstSymbol: ")"; secondSymbol: "°"; expLetter: "î" }
        ListElement { letter: "n"; firstSymbol: "-"; secondSymbol: "~"; expLetter: "ń" }
        ListElement { letter: "m"; firstSymbol: "+"; secondSymbol: "€"; expLetter: "ů" }
    }
}
