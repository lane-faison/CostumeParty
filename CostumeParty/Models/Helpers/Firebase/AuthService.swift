import UIKit
import Firebase

public struct AuthService {
    // CREATE USER
    public static func createUser(viewController: UIViewController, email: String, password: String, completion: (() -> Void)?) {
        FirebaseService.FireAuth.createUser(withEmail: email, password: password) { (firebaseUser, error) in
            
            defer { completion?() }
            
            if error != nil {
                guard let error = error else { return }
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
            } else {
                guard let user = firebaseUser else { return }
                
                createUserObject(name: user.displayName, id: user.uid, completion: {
                    let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                    AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
                })
            }
        }
    }
    
    // CREATE USER OBJECT
    public static func createUserObject(name: String?, id: String, completion: (() -> Void)?) {
        guard let name = name else { return }
        
        FirebaseService.FireDatabase.child("users").childByAutoId().setValue(["name": name, "id": id]) { (error, _) in
            if error == nil {
                completion?()
            }
        }
    }
    
    // LOGOUT USER
    public static func logout(viewController: UIViewController, completion: (() -> Void)?) {
        do {
            try FirebaseService.FireAuth.signOut()
            completion?()
        } catch let error {
            AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
        }
    }
}
