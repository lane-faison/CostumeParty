import UIKit
import Firebase

public struct AuthService {
    // LOGOUT USER
    public static func logout(viewController: UIViewController, completion: (() -> Void)?) {
        do {
            try FireService.FireAuth.signOut()
            completion?()
        } catch let error {
            AlertHelper.fireErrorActionSheet(viewController: viewController, message: error.localizedDescription)
        }
    }
}
