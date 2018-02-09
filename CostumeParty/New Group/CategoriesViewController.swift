import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var party: Party?
    
    let stack = UIStackView()
    let addButton = SquareButton()
    
    private var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        setupViewController()
        setupView()
        setupStackView()
    }
}

extension CategoriesViewController {
    
    @objc private func submitTapped() {
        grabInputs {
            guard var party = self.party else { return }
            
            party.categories = self.categories
            
            FirebaseService.createParty(viewController: self, party: party)
            
            guard let lobby = self.navigationController?.viewControllers.filter({ $0 is LobbyViewController }).first else { return }
            self.navigationController?.popToViewController(lobby, animated: true)
        }
    }
    
    func grabInputs(completion: (() -> Void)?) {
        let textFields = stack.subviews.filter { $0 is PrimaryTextField }
        for field in textFields {
            guard let textField = field as? PrimaryTextField,
                let category = textField.text,
                !category.isEmpty,
                category != " " else { continue }
            categories.append(category)
        }
        if categories.count > 0 {
            completion?()
        }
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
        
        addButton.primaryColor = .affirmativeColor
        addButton.setTitle("NEW CATEGORY", for: .normal)
        addButton.titleLabel?.textColor = .lightTextColor
        addButton.buttonHeight = 80.0
        addButton.addTarget(self, action: #selector(addCategoryField), for: .touchUpInside)
        mainView.addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
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

extension CategoriesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + scrollViewHeight + 200 >= scrollContentSizeHeight {
            fadeAddButtonIn(addButton)
        } else {
            fadeAddButtonOut(addButton)
        }
    }
}

extension CategoriesViewController {
    private func fadeAddButtonOut(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.1
            sender.isEnabled = false
        }
    }
    
    private func fadeAddButtonIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 1.0
            sender.isEnabled = true
        }
    }
}
