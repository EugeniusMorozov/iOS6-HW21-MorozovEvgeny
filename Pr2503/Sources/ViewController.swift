import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var button: UIButton!
    
    var isBlack: Bool = false {
        didSet {
            self.view.backgroundColor = isBlack ? .black : .white
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            self.bruteForce(passwordToUnlock: "000000")
        }
    }

    // MARK: - Functions

    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters:   [String] = String().printable.map { String($0) }
        var password: String = ""

        while password != passwordToUnlock {
            password = String.generateBruteForce(password, fromArray: allowedCharacters)
            // Your stuff here
            print(password)
            // Your stuff here
        }
        
        print(password)
    }

    // MARK: - Actions

    @IBAction func onButtonTapped(_ sender: Any) {
        isBlack.toggle()
    }
}

// MARK: - Extensions

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation}

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
