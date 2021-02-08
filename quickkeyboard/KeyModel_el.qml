import QtQuick 2.0

Item {
    property QtObject firstRowModel: first
    property QtObject secondRowModel: second
    property QtObject thirdRowModel: third


    ListModel {
        id:first
        ListElement { letter: "q"; firstSymbol: "1"; secondSymbol: "1"; expLetter: "q" }
        ListElement { letter: "ς"; firstSymbol: "2"; secondSymbol: "2"; expLetter: "w" }
        ListElement { letter: "ε"; firstSymbol: "3"; secondSymbol: "3"; expLetter: "e" }
        ListElement { letter: "ρ"; firstSymbol: "4"; secondSymbol: "4"; expLetter: "r" }
        ListElement { letter: "τ"; firstSymbol: "5"; secondSymbol: "5"; expLetter: "t" }
        ListElement { letter: "υ"; firstSymbol: "6"; secondSymbol: "6"; expLetter: "y" }
        ListElement { letter: "θ"; firstSymbol: "7"; secondSymbol: "7"; expLetter: "u" }
        ListElement { letter: "ι"; firstSymbol: "8"; secondSymbol: "8"; expLetter: "i" }
        ListElement { letter: "ο"; firstSymbol: "9"; secondSymbol: "9"; expLetter: "o" }
        ListElement { letter: "π"; firstSymbol: "0"; secondSymbol: "0"; expLetter: "p" }
    }
    ListModel {
        id:second
        ListElement { letter: "α"; firstSymbol: "!"; secondSymbol: "|"; expLetter: "a" }
        ListElement { letter: "σ"; firstSymbol: "@"; secondSymbol: "^"; expLetter: "s" }
        ListElement { letter: "δ"; firstSymbol: "#"; secondSymbol: "<"; expLetter: "d" }
        ListElement { letter: "φ"; firstSymbol: "$"; secondSymbol: ">"; expLetter: "f" }
        ListElement { letter: "γ"; firstSymbol: "%"; secondSymbol: "{"; expLetter: "g" }
        ListElement { letter: "η"; firstSymbol: "&"; secondSymbol: "}"; expLetter: "h" }
        ListElement { letter: "ξ"; firstSymbol: "*"; secondSymbol: "["; expLetter: "j" }
        ListElement { letter: "κ"; firstSymbol: "?"; secondSymbol: "]"; expLetter: "k" }
        ListElement { letter: "λ"; firstSymbol: "/"; secondSymbol: "="; expLetter: "l" }
    }
    ListModel {
        id:third
        ListElement { letter: "ζ"; firstSymbol: "_"; secondSymbol: "\\"; expLetter: "z" }
        ListElement { letter: "χ"; firstSymbol: "\""; secondSymbol: ":"; expLetter: "x" }
        ListElement { letter: "ψ"; firstSymbol: "'"; secondSymbol: ";"; expLetter: "c" }
        ListElement { letter: "ω"; firstSymbol: "("; secondSymbol: "`"; expLetter: "v" }
        ListElement { letter: "β"; firstSymbol: ")"; secondSymbol: "°"; expLetter: "b" }
        ListElement { letter: "ν"; firstSymbol: "-"; secondSymbol: "~"; expLetter: "n" }
        ListElement { letter: "μ"; firstSymbol: "+"; secondSymbol: "€"; expLetter: "m" }
    }
}
