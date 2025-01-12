//
//  BruteForceOperation.swift
//  Pr2503
//
//  Created by Evgeny Morozov on 20.07.2022.
//

import Foundation

protocol BruteForceOperationDelegate {
    func showIntermediateValue(value: String)
}

class BruteForceOperation: Operation {

    var delegate: BruteForceOperationDelegate?
    var bruteforcedPassword: String = ""
    let passwordToUnlock: String
    var isBruteForced = false

    init(passwordToUnlock: String) {
        self.passwordToUnlock = passwordToUnlock
    }

    override func main() {
        guard !isCancelled else { return }
        
        isBruteForced = bruteForce(passwordToUnlock: passwordToUnlock)
    }

    func bruteForce(passwordToUnlock: String) -> Bool {
        let allowedCharacters:   [String] = String().printable.map { String($0) }
        var password: String = ""

        while password != passwordToUnlock {
            guard !isCancelled else { return false }
            password = String.generateBruteForce(password, fromArray: allowedCharacters)
            if let delegate = delegate {
                delegate.showIntermediateValue(value: password)
            }
        }
        bruteforcedPassword = password
        return true
    }
}
