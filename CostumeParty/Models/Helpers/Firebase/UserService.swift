import UIKit
import Firebase

public struct UserService {
    // CREATE USER
    public static func createUser(viewController: UIViewController, email: String, password: String, completion: (() -> Void)?) {
        FireService.FireAuth.createUser(withEmail: email, password: password) { (firebaseUser, error) in
            
            defer { completion?() }
            
            if error != nil {
                guard let error = error else { return }
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
            } else {
                guard let user = firebaseUser else { return }
                
                createUserObject(viewController: viewController, email: user.email, id: user.uid, completion: {
                    let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                    AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
                })
            }
        }
    }
    
    // CREATE USER OBJECT
    public static func createUserObject(viewController: UIViewController, email: String?, id: String, completion: (() -> Void)?) {
        guard let email = email else { return }
        
        FireService.FireDatabase.child("users").child(id).setValue(["email": email, "id": id]) { (error, _) in
            if error == nil {
                completion?()
            } else {
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: "\(error.debugDescription)")
            }
        }
    }
    
    // FETCH CURRENT USER (OBJECT)
    public static func fetchCurrentUserObject(completion: @escaping ((User) -> ())) {
        guard let user = FireService.firebaseUser() else { return }
        
        FireService.FireDatabase.child("users").child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else { return }
            
            let email = value["email"] as? String ?? ""
            let id = value["id"] as? String ?? ""
            let user = User(email: email, id: id)
            
            completion(user)
        }
    }
}
