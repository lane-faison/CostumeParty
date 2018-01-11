import UIKit

public struct Party {
    var name: String
    var zipCode: Int
    var hostId: String
    
    init(name: String, zipCode: Int, hostId: String) {
        self.name = name
        self.zipCode = zipCode
        self.hostId = hostId
    }
}
