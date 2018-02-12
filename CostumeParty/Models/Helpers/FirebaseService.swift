import UIKit
import Firebase

public struct FirebaseService {
    
    private static let FireDatabase = Database.database().reference()
    private static let FireAuth = Auth.auth()
    
    public static let firebaseUser = {
        return Auth.auth().currentUser
    }
    
    // AUTHENTICATION
    public static func createUser(viewController: UIViewController, email: String, password: String, completion: (() -> Void)?) {
        FireAuth.createUser(withEmail: email, password: password) { (firebaseUser, error) in
            
            defer { completion?() }
            
            if error != nil {
                guard let error = error else { return }
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
            } else {
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
    
    public static func logout(viewController: UIViewController) {
        do {
            try FireAuth.signOut()
            viewController.navigationController?.popToRootViewController(animated: true)
        } catch let error {
            AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
        }
    }
    
    // DATABASE
    public static func createParty(viewController: UIViewController, party: Party) {
        guard let date = DateHelper.convertDateToString(date: party.date) else { return }
        
        FireDatabase.child("parties").childByAutoId().setValue(["name": party.name,
                                                                "hostId": party.hostId,
                                                                "zipcode": party.zipCode,
                                                                "date": date,
                                                                "pin": party.pin,
                                                                "categories": party.categories ?? []])
    }
    
    public static func fetchPartiesByZipcode(viewController: UIViewController, zipcode: Int, completion: @escaping (([Party]) -> ())) {
        
        FireDatabase.child("parties").observeSingleEvent(of: .value) { (snapshot) in
            var parties: [Party] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let json = child.value as? [String: Any] else { continue }
                
                guard let name = json["name"] as? String,
                    let hostId = json["hostId"] as? String,
                    let partyZipcode = json["zipcode"] as? Int,
                    let dateString = json["date"] as? String,
                    let date = DateHelper.convertStringToDate(string: dateString),
                    let pin = json["pin"] as? Int,
                    let categories = json["categories"] as? [String] else { continue }
                
                if zipcode == partyZipcode {
                    let party = Party.init(name: name, zipCode: partyZipcode, hostId: hostId, date: date, pin: pin, categories: categories)
                    parties.append(party)
                }
            }
            completion(parties)
        }
    }
}
