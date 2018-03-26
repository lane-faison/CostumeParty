import UIKit
import Firebase

public struct FirebaseService {
    
    public static let FireDatabase = Database.database().reference()
    public static let FireAuth = Auth.auth()
    
    public static let firebaseUser = {
        return Auth.auth().currentUser
    }
}
