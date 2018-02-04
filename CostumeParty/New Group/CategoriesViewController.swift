import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    var party: Party?
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitTapped()
    }
}

extension CategoriesViewController {
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "Next, add some costume categories for your party!\n(Maximum of 10)"
        headingLabel.textColor = .darkTextColor
        
        submitButton.setTitle("FINISHED", for: .normal)
        submitButton.primaryColor = .affirmativeColor
    }
    
    private func submitTapped() {
        print("SUBMIT TAPPED")
    }
}
