import UIKit

public struct Event: Decodable {
    var name: String
    var id: String
    var zipCode: Int
    var hostId: String
    var date: Date
    var pin: Int
    var categories: [String]?
    var guests: [User]?
    
    init(name: String, zipCode: Int, hostId: String, date: Date, pin: Int, categories: [String]? = nil, guests: [User]? = nil) {
        self.name = name
        self.id = name + hostId
        self.zipCode = zipCode
        self.hostId = hostId
        self.date = date
        self.pin = pin
        self.categories = categories
        self.guests = guests
    }
}
