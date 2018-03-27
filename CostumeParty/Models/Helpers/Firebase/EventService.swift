import UIKit
import Firebase

public struct EventService {
    // CREATE EVENT
    public static func createEvent(viewController: UIViewController, event: Event, completion: (() -> Void)?) {
        guard let date = DateHelper.convertDateToString(date: event.date) else { return }
        
        FireService.FireDatabase.child("events").childByAutoId().setValue(
            ["name": event.name,
             "id": event.id,
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
    
    // FETCH EVENT BY ZIP CODE
    public static func fetchEventsByZipcode(viewController: UIViewController, zipcode: Int, completion: @escaping (([Event]) -> ())) {
        FireService.FireDatabase.child("events").observeSingleEvent(of: .value) { (snapshot) in
            var events: [Event] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                guard let json = child.value as? [String: Any], 
                    let eventZipcode = json["zipcode"] as? Int else { continue }
                
                if zipcode == eventZipcode {
                    guard let name = json["name"] as? String,
                        let hostId = json["hostId"] as? String,
                        let dateString = json["date"] as? String,
                        let date = DateHelper.convertStringToDate(string: dateString),
                        let pin = json["pin"] as? Int,
                        let categories = json["categories"] as? [String] else { return }
                    
                    let event = Event.init(name: name, zipCode: eventZipcode, hostId: hostId, date: date, pin: pin, categories: categories)
                    events.append(event)
                }
            }
            completion(events)
        }
    }
    
    // ADD USER TO EVENT
    public static func addUserToEvent(_ event: Event, user: User, completion: (() -> Void)?) {
        
    }
}
