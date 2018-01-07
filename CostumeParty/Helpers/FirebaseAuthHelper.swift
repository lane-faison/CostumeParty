import UIKit
import Firebase

public struct FirebaseAuthHelper {
    public static func createUser(viewController: UIViewController, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                let message = "There was an error when creating your account. Please try again."
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: message)
                print("Error creating user: \(error!)")
            } else {
                guard let user = user else { return }
                Database.database().reference().child("users").child(user.uid).child("email").setValue(user.email)
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
}
