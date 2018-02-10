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
        FireDatabase.child("parties").childByAutoId().setValue(["name": party.name,
                                                                "hostId": party.hostId,
                                                                "zipcode": party.zipCode,
                                                                "categories": party.categories ?? []])
    }
    
    public static func fetchPartiesByZipcode(viewController: UIViewController, zipcode: Int, completion: @escaping (([Party]) -> ())) {
        
        FireDatabase.child("parties").observeSingleEvent(of: .value) { (snapshot) in
            var parties: [Party] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let json = child.value as? [String: Any] else { continue }
                
                guard let name = json["name"] as? String,
                    let hostId = json["hostId"] as? String,
                    let zipcode = json["zipcode"] as? Int,
                    let categories = json["categories"] as? [String] else { continue }
                
                let party = Party.init(name: name, zipCode: zipcode, hostId: hostId, date: nil, categories: categories)
                
                parties.append(party)
            }
            completion(parties)
        }
    }
}
