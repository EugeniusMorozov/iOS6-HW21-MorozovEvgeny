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
        
        let operation = BrutForceOperation(passwordToUnlock: "0000")
        let queue = OperationQueue()
        queue.addOperation(operation)
    }

    // MARK: - Actions

    @IBAction func onButtonTapped(_ sender: Any) {
        isBlack.toggle()
    }
}
