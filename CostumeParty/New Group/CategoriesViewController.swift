import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: PrimaryButton!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    var party: Party?
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        
        view.applyPrimaryBackgroundGradient()
        setupView()
    }

    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        addCategoryTapped()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitTapped()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
        cell.sectionTextField.placeholder = categories[indexPath.row]
        return cell
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
        print("Category tapped")
        tableView.beginUpdates()
        let lastIndexPath: IndexPath = IndexPath(row: categories.count, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .top)
        categories.append("ex. Best Costume")
        tableView.endUpdates()
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    private func submitTapped() {
        //    guard let user = user else { return }
        //    
        //    let nameCell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as? RegisterTableViewCell
        //    let zipcodeCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as? RegisterTableViewCell
        //    
        //    guard let name = nameCell?.sectionTextField.text, let zipcodeString = zipcodeCell?.sectionTextField.text else { return }
        //    
        //    if let zipcode = Int(zipcodeString) {
        //    let party = Party(name: name, zipCode: zipcode, hostId: user.uid)
        //    
        //    FirebaseService.createParty(viewController: self, party: party)
    }
}
