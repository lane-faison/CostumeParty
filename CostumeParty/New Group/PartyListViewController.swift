import UIKit

class PartyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    fileprivate var parties: [Party] = [] {
        didSet {
            tableView.reloadData()
            activityIndicator.stopAnimating()
            tableView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentSearch()
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "PartyTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: PartyTableViewCell.reuseIdentifier)
        
        setupViewController()
        setupView()
    }
}

extension PartyListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PartyTableViewCell = tableView.dequeueReusableCell(withIdentifier: PartyTableViewCell.reuseIdentifier) as! PartyTableViewCell
        let party = parties[indexPath.row]
        
        cell.partyLabel.text = party.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension PartyListViewController {
    private func setupView() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func presentSearch() {
        let alert = UIAlertController(title: "Event Location", message: "Please enter the 5-digit ZIP Code of the event you are attending", preferredStyle: .alert)
        let action = UIAlertAction(title: "Search", style: .default) { [weak self] alertAction in
            guard let strongSelf = self else { return }
            
            strongSelf.activityIndicator.startAnimating()
            
            let textField = alert.textFields![0] as UITextField
            
            guard let zipcodeString = textField.text else { return }
            guard let zipcode = Int(zipcodeString) else { return }
            
            FirebaseService.fetchPartiesByZipcode(viewController: strongSelf, zipcode: zipcode) { (result) -> () in
                strongSelf.parties = result
                strongSelf.title = "\(zipcode)"
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "(required)"
            textField.keyboardType = .numberPad
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func searchTapped() {
        presentSearch()
    }
}
