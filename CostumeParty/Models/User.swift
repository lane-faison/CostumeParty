import UIKit

public struct User: Decodable {
    var name: String
    var id: String
    var description: String?
    var currentEvent: Event?
    
    init(name: String, id: String, description: String? = nil, currentEvent: Event? = nil) {
        self.name = name
        self.id = id
        self.description = description
        self.currentEvent = currentEvent
    }
}
