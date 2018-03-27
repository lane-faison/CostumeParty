import UIKit

public struct User: Decodable {
    var email: String
    var id: String
    var description: String?
    var currentEvent: Event?
    
    init(email: String, id: String, description: String? = nil, currentEvent: Event? = nil) {
        self.email = email
        self.id = id
        self.description = description
        self.currentEvent = currentEvent
    }
}
