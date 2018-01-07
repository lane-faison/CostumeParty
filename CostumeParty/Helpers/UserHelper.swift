import Foundation

public enum UserType: String {
    case guest = "guest"
    case host = "host"
}

public struct User {
    var email: String
    var costume: String
    var userType: UserType
    
    init(email: String, costume: String, userType: UserType) {
        self.email = email
        self.costume = costume
        self.userType = userType
    }
}
