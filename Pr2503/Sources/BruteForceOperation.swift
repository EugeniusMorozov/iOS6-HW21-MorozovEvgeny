//
//  BruteForceOperation.swift
//  Pr2503
//
//  Created by Evgeny Morozov on 20.07.2022.
//

import Foundation

class BruteForceOperation: Operation {
    var bruteforcedPassword: String = ""
    let passwordToUnlock: String

    init(passwordToUnlock: String) {
        self.passwordToUnlock = passwordToUnlock
    }

    override func main() {
        if self.isCancelled { return }

        if bruteForce(passwordToUnlock: passwordToUnlock) {
            print("Password was brute forced.")
        }
    }

    func bruteForce(passwordToUnlock: String) -> Bool {
        let allowedCharacters:   [String] = String().printable.map { String($0) }
        var password: String = ""

        while password != passwordToUnlock {
            password = String.generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        bruteforcedPassword = password
        return true
    }
}
