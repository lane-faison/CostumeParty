import UIKit
import Firebase

public struct FirebaseService {
    
    private static let FireDatabase = Database.database().reference()
    private static let FireAuth = Auth.auth()
    
    public static let firebaseUser = {
        return Auth.auth().currentUser
    }
    
    // AUTHENTICATION
    public static func createUser(viewController: UIViewController, email: String, password: String, completion: (() -> Void)?) {
        FireAuth.createUser(withEmail: email, password: password) { (firebaseUser, error) in
            
            defer { completion?() }
            
            if error != nil {
                guard let error = error else { return }
                AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
            } else {
                let message = "Congratulations! Your account has been successfully created. Please log in to continue!"
                AlertHelper.fireSuccessActionSheet(viewController: viewController, message: message)
            }
        }
    }
    
    public static func logout(viewController: UIViewController, completion: (() -> Void)?) {
        do {
            try FireAuth.signOut()
            completion?()
        } catch let error {
            AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
        }
    }
    
    // DATABASE
    public static func createEvent(viewController: UIViewController, event: Event, completion: (() -> Void)?) {
        guard let date = DateHelper.convertDateToString(date: event.date) else { return }
        
        FireDatabase.child("events").childByAutoId().setValue(["name": event.name,
                                                               "hostId": event.hostId,
                                                               "zipcode": event.zipCode,
                                                               "date": date,
                                                               "pin": event.pin,
                                                               "categories": event.categories ?? []]) { (error, _) in
                                                                if error == nil {
                                                                    completion?()
                                                                }
        }
    }
    
    public static func fetchEventsByZipcode(viewController: UIViewController, zipcode: Int, completion: @escaping (([Event]) -> ())) {
        
        FireDatabase.child("events").observeSingleEvent(of: .value) { (snapshot) in
            var events: [Event] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let json = child.value as? [String: Any] else { continue }
                
                guard let name = json["name"] as? String,
                    let hostId = json["hostId"] as? String,
                    let eventZipcode = json["zipcode"] as? Int,
                    let dateString = json["date"] as? String,
                    let date = DateHelper.convertStringToDate(string: dateString),
                    let pin = json["pin"] as? Int,
                    let categories = json["categories"] as? [String] else { continue }
                
                if zipcode == eventZipcode {
                    let event = Event.init(name: name, zipCode: eventZipcode, hostId: hostId, date: date, pin: pin, categories: categories)
                    events.append(event)
                }
            }
            completion(events)
        }
    }
}
