import UIKit

extension UIViewController {
    
    // Used to hide the back button title. Add this in any View Controller's viewDidLoad function
    open func hideBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}
