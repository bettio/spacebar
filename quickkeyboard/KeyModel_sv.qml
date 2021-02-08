import QtQuick 2.0

Item {
    property QtObject firstRowModel: first
    property QtObject secondRowModel: second
    property QtObject thirdRowModel: third


    ListModel {
        id:first
        ListElement { letter: "q"; firstSymbol: "1"; secondSymbol: "1"; expLetter: "ń" }
        ListElement { letter: "w"; firstSymbol: "2"; secondSymbol: "2"; expLetter: "đ" }
        ListElement { letter: "e"; firstSymbol: "3"; secondSymbol: "3"; expLetter: "ý" }
        ListElement { letter: "r"; firstSymbol: "4"; secondSymbol: "4"; expLetter: "ÿ" }
        ListElement { letter: "t"; firstSymbol: "5"; secondSymbol: "5"; expLetter: "à" }
        ListElement { letter: "y"; firstSymbol: "6"; secondSymbol: "6"; expLetter: "á" }
        ListElement { letter: "u"; firstSymbol: "7"; secondSymbol: "7"; expLetter: "â" }
        ListElement { letter: "i"; firstSymbol: "8"; secondSymbol: "8"; expLetter: "ã" }
        ListElement { letter: "o"; firstSymbol: "9"; secondSymbol: "9"; expLetter: "æ" }
        ListElement { letter: "p"; firstSymbol: "0"; secondSymbol: "0"; expLetter: "å" }
    }
    ListModel {
        id:second
        ListElement { letter: "a"; firstSymbol: "!"; secondSymbol: "|"; expLetter: "è" }
        ListElement { letter: "s"; firstSymbol: "@"; secondSymbol: "^"; expLetter: "é" }
        ListElement { letter: "d"; firstSymbol: "#"; secondSymbol: "<"; expLetter: "ë" }
        ListElement { letter: "f"; firstSymbol: "$"; secondSymbol: ">"; expLetter: "ï" }
        ListElement { letter: "g"; firstSymbol: "%"; secondSymbol: "{"; expLetter: "ì" }
        ListElement { letter: "h"; firstSymbol: "&"; secondSymbol: "}"; expLetter: "í" }
        ListElement { letter: "j"; firstSymbol: "*"; secondSymbol: "["; expLetter: "î" }
        ListElement { letter: "k"; firstSymbol: "?"; secondSymbol: "]"; expLetter: "ö" }
        ListElement { letter: "l"; firstSymbol: "/"; secondSymbol: "="; expLetter: "ä" }
    }
    ListModel {
        id:third
        ListElement { letter: "z"; firstSymbol: "_"; secondSymbol: "\\"; expLetter: "ò" }
        ListElement { letter: "x"; firstSymbol: "\""; secondSymbol: ":"; expLetter: "ó" }
        ListElement { letter: "c"; firstSymbol: "'"; secondSymbol: ";"; expLetter: "õ" }
        ListElement { letter: "v"; firstSymbol: "("; secondSymbol: "`"; expLetter: "ø" }
        ListElement { letter: "b"; firstSymbol: ")"; secondSymbol: "°"; expLetter: "œ" }
        ListElement { letter: "n"; firstSymbol: "-"; secondSymbol: "~"; expLetter: "ù" }
        ListElement { letter: "m"; firstSymbol: "+"; secondSymbol: "€"; expLetter: "ú" }
    }
}
