import UIKit

public struct AlertHelper {
    
    // ERROR
    public static func fireErrorActionSheet(viewController: UIViewController, title: String? = "Error", message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    // SUCCESSFUL REGISTRATION
    public static func fireSuccessActionSheet(viewController: UIViewController, title: String? = "Success", message: String, dismissButtonTitle: String? = "Dismiss") {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: dismissButtonTitle, style: .default) { _ in
            viewController.navigationController?.popToRootViewController(animated: true)
        }
        actionSheet.addAction(dismiss)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}