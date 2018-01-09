import UIKit
import Firebase

public struct FirebaseAuthHelper {
    
    private static let FireDatabase = Database.database().reference()
    private static let FireAuth = Auth.auth()
    
    public static func createUser(viewController: UIViewController, user: User, password: String, party: Party? = nil) {
        FireAuth.createUser(withEmail: user.email, password: password) { (firebaseUser, error) in
            
            if error != nil {
                let message = "There was an error when creating your account. Please try again."
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: message)
            } else {
                guard let firebaseUser = firebaseUser else { return }
                FireDatabase.child("users").child(firebaseUser.uid).child("email").setValue(firebaseUser.email)
                FireDatabase.child("users").child(firebaseUser.uid).updateChildValues(["costume": user.costume, "userType": user.userType.rawValue])
                if let party = party, user.userType == .host {
                    FireDatabase.child("parties").child(firebaseUser.uid).updateChildValues(["name": party.name, "zipCode": party.zipCode])
                }
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
    
    public static func logout(viewController: UIViewController, user: User) {
        do {
            try FireAuth.signOut()
            viewController.navigationController?.popToRootViewController(animated: true)
        } catch let error {
            AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
        }

    }
}
