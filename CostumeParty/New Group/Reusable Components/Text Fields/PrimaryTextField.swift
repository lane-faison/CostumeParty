import UIKit

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
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
    
    override var text: String? {
        didSet {
            animateWhenActive(fieldLabel)
        }
    }
    
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
        font = UIFont.h4
        contentVerticalAlignment = .bottom
        textColor = .darkTextColor
        
        addSubview(fieldLabel)
        fieldLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fieldLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(bottomBorder)
        bottomBorder.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomBorder.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        bottomBorder.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBorder.centerYAnchor.constraint(equalTo: bottomAnchor, constant: 2.0).isActive = true
    }
    
    private func setupKeyboard() {
        autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fadeColors(self, toColor: .darkTextColor)
        
        if textField.text?.isEmpty ?? false {
            animateWhenActive(fieldLabel)
        }
        bottomBorder.backgroundColor = .darkTextColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fadeColors(self, toColor: .inactiveColor)
        
        if textField.text?.isEmpty ?? false {
            animateWhenInactive(fieldLabel)
        }
        bottomBorder.backgroundColor = .inactiveColor
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fadeColors(self, toColor: .inactiveColor)
        
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    private func animateWhenActive(_ sender: UILabel) {
        let scaleRatio: CGFloat = 0.6
        let labelDistanceToLeft = -1 * (frame.width - sender.frame.width * scaleRatio)/2
        let labelDistanceToTop = -0.4 * (frame.height)
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        sender.transform = CGAffineTransform(translationX: labelDistanceToLeft, y: labelDistanceToTop)
                            .scaledBy(x: scaleRatio, y: scaleRatio)
        }) { Void in() }
    }
    
    private func animateWhenInactive(_ sender: UILabel) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        }) { Void in() }
    }
    
    private func fadeColors(_ sender: PrimaryTextField, toColor: UIColor) {
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            sender.fieldLabel.textColor = toColor
            sender.bottomBorder.backgroundColor = toColor
        }) { Void in() }
    }
}
