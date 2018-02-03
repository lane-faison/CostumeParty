import UIKit

class CredentialsTextField: UITextField, UITextFieldDelegate {
    
    private let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.inactiveColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fieldLabel: UILabel = {
        let label = UILabel()
        label.text = "default"
        label.textColor = UIColor.inactiveColor
        label.font = .h4
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        delegate = self
        setupDisplay()
        setupKeyboard()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        setupDisplay()
        setupKeyboard()
    }
    
    private func setupDisplay() {
        self.font = UIFont.h4
        
        self.addSubview(fieldLabel)
        fieldLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fieldLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(bottomBorder)
        bottomBorder.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomBorder.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        bottomBorder.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bottomBorder.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: 2.0).isActive = true
    }
    
    private func setupKeyboard() {
        self.autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            animateWhenActive(fieldLabel)
        }
        self.bottomBorder.backgroundColor = .darkTextColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            animateWhenInactive(fieldLabel)
        }
        self.bottomBorder.backgroundColor = .inactiveColor
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func setPlaceholderText(_ placeholderTxt: String) {
//
//        attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkTextColor.darkerColor()])
//        textColor = .darkTextColor
//
//        layoutSubviews()
//    }
    
    func animateWhenActive(_ sender: UILabel) {
        let scaleRatio: CGFloat = 0.6
        let labelDistanceToLeft = -1 * (self.frame.width - sender.frame.width * scaleRatio)/2
        let labelDistanceToTop = -0.4 * (self.frame.height)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.fieldLabel.transform = CGAffineTransform(translationX: labelDistanceToLeft, y: labelDistanceToTop)
                            .scaledBy(x: scaleRatio, y: scaleRatio)
        },
                       completion: { Void in()  }
        )
    }
    
    func animateWhenInactive(_ sender: UILabel) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.fieldLabel.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        },
                       completion: { Void in()  }
        )
    }
}
