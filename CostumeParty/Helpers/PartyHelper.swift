import UIKit

public struct Party {
    var name: String
    var zipCode: Int
    var host: User
    
    init(name: String, zipCode: Int, host: User) {
        self.name = name
        self.zipCode = zipCode
        self.host = host
    }
}
