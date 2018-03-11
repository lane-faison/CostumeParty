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
        cell.iconImage = UIImage(named: "ghost")
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
                if result.count == 0 {
                    let zeroResultAlert = UIAlertController(title: "0 results found", message: "No events within this zipcode were found", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                        strongSelf.navigationController?.popViewController(animated: false)
                    })
                    let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (_) in
                        strongSelf.presentSearch()
                    })
                    zeroResultAlert.addAction(cancelAction)
                    zeroResultAlert.addAction(tryAgainAction)
                    
                    self?.present(zeroResultAlert, animated: true, completion: nil)
                    
                }
                strongSelf.parties = result
                strongSelf.title = "\(zipcode)"
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.navigationController?.popViewController(animated: false)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "(required)"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func searchTapped() {
        presentSearch()
    }
}

