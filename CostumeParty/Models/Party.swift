import UIKit

public struct Party {
    var name: String
    var zipCode: Int
    var hostId: String
    var date: Date?
    var categories: [String]?
    
    init(name: String, zipCode: Int, hostId: String, date: Date? = nil, categories: [String]? = nil) {
        self.name = name
        self.zipCode = zipCode
        self.hostId = hostId
        self.date = date
        self.categories = categories
    }
}