import UIKit
import Firebase

public struct FirebaseAuthHelper {
    public static func createUser(viewController: UIViewController, user: User, password: String) {
        Auth.auth().createUser(withEmail: user.email, password: password) { (firebaseUser, error) in
            
            if error != nil {
                let message = "There was an error when creating your account. Please try again."
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: message)
                print("Error creating user: \(error!)")
            } else {
                guard let firebaseUser = firebaseUser else { return }
                Database.database().reference().child("users").child(firebaseUser.uid).child("email").setValue(firebaseUser.email)
                Database.database().reference().child("users").child(firebaseUser.uid).updateChildValues(["costume": user.costume, "userType": user.userType.rawValue])
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
}
