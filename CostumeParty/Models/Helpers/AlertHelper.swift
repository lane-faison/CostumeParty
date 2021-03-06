import UIKit

public struct AlertHelper {
    
    // ERROR
    static func fireErrorActionSheet(viewController: UIViewController, title: String? = "Error", message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    // INFO
    static func fireInfoActionSheet(viewController: UIViewController, title: String? = "Information", message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        actionSheet.addAction(dismiss)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    // CANCEL OR OKAY (No action on cancel for now)
    static func fireCancelOrActionAlert(viewContoller: UIViewController, title: String, message: String, okayTitle: String? = "Okay", okayAction: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: okayTitle, style: .default) { _ in
            okayAction()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okay)
        alert.addAction(cancel)
        
        viewContoller.present(alert, animated: true, completion: nil)
    }
    
    // SUCCESSFUL REGISTRATION
    static func fireSuccessActionSheet(viewController: UIViewController, title: String? = "Success", message: String, dismissButtonTitle: String? = "Dismiss") {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: dismissButtonTitle, style: .default) { _ in
            viewController.navigationController?.popToRootViewController(animated: true)
        }
        actionSheet.addAction(dismiss)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
