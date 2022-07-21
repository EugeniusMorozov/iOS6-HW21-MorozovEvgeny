//
//  String.swift
//  Pr2503
//
//  Created by Evgeny Morozov on 19.07.2022.
//

extension String {
    var digits:           String { return "0123456789" }
    var lowercase:        String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:        String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation:      String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:          String { return lowercase + uppercase }
    var lettersAndDigits: String { return letters + digits }
    var printable:        String { return letters + digits + punctuation}

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }

    static func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    static func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }

    static func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}
