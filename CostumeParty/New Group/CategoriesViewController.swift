import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var addCategoryButton: PrimaryButton!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    var party: Party?
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyPrimaryBackgroundGradient()
        setupViewController()
        setupView()
    }

    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        addCategoryTapped()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitTapped()
    }
}

extension CategoriesViewController {
    private func setupView() {
        headingLabel.font = .h2
        headingLabel.text = "Next, add some costume categories for your party!"
        headingLabel.textColor = .primaryTextColor
        
        addCategoryButton.setTitle("ADD NEW CATEGORY", for: .normal)
        addCategoryButton.primaryColor = .secondaryLightColor
        
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.primaryColor = .secondaryColor
    }
    
    private func addCategoryTapped() {
        print("ADD TAPPED")
    }
    
    private func submitTapped() {
        print("SUBMIT TAPPED")
    }
}
