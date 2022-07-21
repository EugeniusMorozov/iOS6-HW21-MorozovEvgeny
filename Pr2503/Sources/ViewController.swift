import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var changeBackgroundColorButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var password: String?
    var isBlack: Bool = false {
        didSet {
            self.view.backgroundColor = isBlack ? .black : .white
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operation = BrutForceOperation(passwordToUnlock: "0000")
        let queue = OperationQueue()
        queue.addOperation(operation)
    }

    // MARK: - Actions

    @IBAction func changeBackgroundColorButtonTapped(_ sender: Any) {
        isBlack.toggle()
    }

    @IBAction func generatePasswordButtonTapped(_ sender: Any) {

    }
}
