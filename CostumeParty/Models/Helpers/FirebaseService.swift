import UIKit
import Firebase

public struct FirebaseService {
    
    private static let FireDatabase = Database.database().reference()
    private static let FireAuth = Auth.auth()
    
    public static let firebaseUser = {
        return Auth.auth().currentUser
    }
    
    // AUTHENTICATION
    public static func createUser(viewController: UIViewController, email: String, password: String) {
        FireAuth.createUser(withEmail: email, password: password) { (firebaseUser, error) in
            
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
        FireDatabase.child("parties").child(party.name).setValue(["hostId": party.hostId, "zipcode": party.zipCode])
    }
    
}
