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
