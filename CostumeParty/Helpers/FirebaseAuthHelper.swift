import UIKit
import Firebase

public struct FirebaseAuthHelper {
    public static func createUser(viewController: UIViewController, user: User, password: String, party: Party? = nil) {
        Auth.auth().createUser(withEmail: user.email, password: password) { (firebaseUser, error) in
            
            if error != nil {
                let message = "There was an error when creating your account. Please try again."
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: message)
            } else {
                guard let firebaseUser = firebaseUser else { return }
                Database.database().reference().child("users").child(firebaseUser.uid).child("email").setValue(firebaseUser.email)
                Database.database().reference().child("users").child(firebaseUser.uid).updateChildValues(["costume": user.costume, "userType": user.userType.rawValue])
                if let party = party, user.userType == .host {
                    Database.database().reference().child("parties").child(firebaseUser.uid).updateChildValues(["name": party.name, "zipCode": party.zipCode])
                }
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
}
