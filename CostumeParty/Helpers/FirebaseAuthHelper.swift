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
    
    public static func userLogin(viewController: UIViewController, email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let error = error {
                    AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
                }
            } else {
                guard let firebaseUser = user else { return }
                
                Database.database().reference().child("users").child(firebaseUser.uid).observe(.value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    guard let email = value?["email"] as? String,
                        let costume = value?["costume"] as? String,
                        let userTypeString = value?["userType"] as? String else { return }
                        
                        let userType: UserType = userTypeString == "host" ? .host : .guest
                        
                        let loggedInUser = User(email: email, costume: costume, userType: userType)
                        
                        if loggedInUser.userType == .host {
                            viewController.navigationController?.performSegue(withIdentifier: "loggedInAsHost", sender: viewController)
                        } else {
                            viewController.navigationController?.performSegue(withIdentifier: "loggedInAsGuest", sender: viewController)
                        }
                })
            }
        }
    }
}
