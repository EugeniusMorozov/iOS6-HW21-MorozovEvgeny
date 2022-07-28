import UIKit

class ViewController: UIViewController  {

    // MARK: - Properties

    @IBOutlet weak var changeBackgroundColorButton: UIButton!
    @IBOutlet weak var bruteForcePasswordButton: UIButton!
    @IBOutlet weak var cancelBruteForcePasswordButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var bruteForcePasswordOperation: BruteForceOperation?
    var isBlack: Bool = false {
        didSet {
            self.view.backgroundColor = isBlack ? .black : .white
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
    }

    // MARK: - Private functions

    private func bruteForcePassword(passwordToUnlock: String) {
        bruteForcePasswordOperation = BruteForceOperation(passwordToUnlock: passwordToUnlock)
        guard let operation = bruteForcePasswordOperation else { return }
        operation.delegate = self
        operation.completionBlock = {
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                self.bruteForcePasswordButton.isEnabled = true
                self.passwordTextField.isEnabled = true
                cancelBruteForcePasswordButton.isEnabled = false
                if operation.isBruteForced {
                    self.passwordTextField.isSecureTextEntry = false
                    self.passwordLabel.text = "Пароль взломан: \(operation.bruteforcedPassword)"
                } else {
                    self.passwordLabel.text = "Пароль: \(operation.passwordToUnlock) не взломан"
                }
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
        bruteForcePasswordButton.isEnabled = false
        passwordTextField.isEnabled = false
        cancelBruteForcePasswordButton.isEnabled = true
        activityIndicator.startAnimating()
        passwordTextField.isSecureTextEntry = true
        passwordLabel.text = ""
        passwordTextField.text = password
        bruteForcePassword(passwordToUnlock: password)
    }

    @IBAction func cancelBruteForcePasswordButtonTapped(_ sender: Any) {
        cancelBruteForcePasswordButton.isEnabled = false
        guard let operation = bruteForcePasswordOperation else { return }
        if !operation.isCancelled {
            operation.cancel()
        }
    }
}

// MARK: - Extensions

extension ViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSecureTextEntry = true
    }
}

extension ViewController: BruteForceOperationDelegate {

    func showIntermediateValue(value: String) {
        DispatchQueue.main.async { [self] in
            self.passwordLabel.text = value
        }
    }
}
