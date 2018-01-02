import UIKit

extension UIViewController {
    
    func setupViewController() {
        hideBackButtonTitle()
        hideKeyboardWhenTappedAround()
    }
    
    // Used to hide the back button title. Add this in any View Controller's viewDidLoad function
    private func hideBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    // Used to hide the keyboard when the user taps the background outside of a UITextField
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
