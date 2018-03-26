import UIKit
import Firebase

public struct UserService {
    // FETCH CURRENT USER
    public static func fetchCurrentUser(byUserId userId: String, completion: @escaping ((User) -> ())) {
        FirebaseService.FireDatabase.child("users").observeSingleEvent(of: .value) { (snapshot) in
            var currentUser: User = User(name: "", id: "")
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let json = child.value as? [String: Any] else { continue }
                
                guard let name = json["name"] as? String,
                    let id = json["id"] as? String  else { continue }
                
                if userId == id {
                    currentUser = User.init(name: name, id: id)
                }
            }
            completion(currentUser)
        }
    }
}
