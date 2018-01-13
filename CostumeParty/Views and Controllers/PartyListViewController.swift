import UIKit

class PartyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var parties: [Party] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "PartyTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: PartyTableViewCell.reuseIdentifier)
        
        loadTestData()
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
}

extension PartyListViewController {
    func loadTestData() {
        let party1 = Party(name: "Lane's Party", zipCode: 80023, hostId: "test")
        let party2 = Party(name: "Amanda's Party", zipCode: 80023, hostId: "test")
        let party3 = Party(name: "Kevin's Party", zipCode: 80023, hostId: "test")
        let party4 = Party(name: "Casey's Party", zipCode: 80302, hostId: "test")
        let party5 = Party(name: "Courtney's Party", zipCode: 80302, hostId: "test")
        let party6 = Party(name: "Ann's Party", zipCode: 80024, hostId: "test")
        let party7 = Party(name: "Sandy's Party", zipCode: 80024, hostId: "test")
        let party8 = Party(name: "Will's Party", zipCode: 80111, hostId: "test")
        let party9 = Party(name: "Katelyn's Party", zipCode: 80021, hostId: "test")
        let party10 = Party(name: "Sandy's Party", zipCode: 80023, hostId: "test")
        let party11 = Party(name: "Ben's Party", zipCode: 80302, hostId: "test")

        parties = [party1, party2, party3, party4, party5, party6, party7, party8, party9, party10, party11]
        tableView.reloadData()
    }
}
