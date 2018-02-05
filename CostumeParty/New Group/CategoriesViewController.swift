import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var party: Party?
    
    let stack = UIStackView()
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
        setupStackView()
    }
}

extension CategoriesViewController {
    
    @objc private func submitTapped() {
        print("SUBMIT TAPPED")
        guard let lobby = self.navigationController?.viewControllers.filter({ $0 is LobbyViewController }).first else { return }
        navigationController?.popToViewController(lobby, animated: true)
    }
}

extension CategoriesViewController {
    
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "Next, let's add some categories for your event."
        headingLabel.textColor = .darkTextColor
        
        let finishedButton = UIBarButtonItem(title: "Finished", style: .plain, target: self, action: #selector(submitTapped))
        navigationItem.rightBarButtonItem = finishedButton
    }
    
    private func setupStackView() {
        let categoryTextField = PrimaryTextField()
        categoryTextField.fieldLabel.text = "Category"
        categoryTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 24.0
        
        stack.addArrangedSubview(categoryTextField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 48.0).isActive = true
        stack.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.8).isActive = true
        stack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        let addButton = PrimaryButton()
        addButton.primaryColor = .affirmativeColor
        addButton.setTitle("ADD", for: .normal)
        addButton.titleLabel?.textColor = .lightTextColor
        addButton.buttonHeight = 80.0
        addButton.addTarget(self, action: #selector(addCategoryField), for: .touchUpInside)
        mainView.addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func addCategoryField() {
        let categoryTextField = PrimaryTextField()
        categoryTextField.fieldLabel.text = "Category"
        categoryTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        stack.addArrangedSubview(categoryTextField)
        
        var contentRect = CGRect.zero
        
        for view in stack.subviews {
            contentRect = contentRect.union(view.frame)
        }
        viewHeight.constant = contentRect.size.height
        
        scrollView.layoutIfNeeded()
        scrollView.layoutSubviews()
    }
}
