import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var changeBackgroundColorButton: UIButton!
    @IBOutlet weak var bruteForcePasswordButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var isBlack: Bool = false {
        didSet {
            self.view.backgroundColor = isBlack ? .black : .white
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private functions

    private func bruteForcePassword(passwordToUnlock: String) {
        let operation = BruteForceOperation(passwordToUnlock: passwordToUnlock)
        operation.completionBlock = {
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                self.bruteForcePasswordButton.isEnabled = true
                self.passwordTextField.isSecureTextEntry = false
                self.passwordLabel.text = "Пароль взломан: \(operation.bruteforcedPassword)"
            }
        }
        let queue = OperationQueue()
        queue.addOperation(operation)
    }

    // MARK: - Actions

    @IBAction func changeBackgroundColorButtonTapped(_ sender: Any) {
        isBlack.toggle()
    }

    @IBAction func bruteForcePasswordButtonTapped(_ sender: Any) {
        guard let password = passwordTextField.text else { return }
        if password == "" { return }
        activityIndicator.startAnimating()
        bruteForcePasswordButton.isEnabled = false
        bruteForcePassword(passwordToUnlock: password)
        passwordTextField.isSecureTextEntry = true
        passwordLabel.text = ""
        passwordTextField.text = password
    }
}
