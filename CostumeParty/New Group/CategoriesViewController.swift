import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    
    var party: Party?
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
}

extension CategoriesViewController {
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "Next, add some costume categories for your party!\n(Maximum of 10)"
        headingLabel.textColor = .darkTextColor
        
        let finishedButton = UIBarButtonItem(title: "Finished", style: .plain, target: self, action: #selector(submitTapped))
        navigationItem.rightBarButtonItem = finishedButton
    }
    
    @objc private func submitTapped() {
        print("SUBMIT TAPPED")
        guard let lobby = self.navigationController?.viewControllers.filter({ $0 is LobbyViewController }).first else { return }
        navigationController?.popToViewController(lobby, animated: true)
    }
}
