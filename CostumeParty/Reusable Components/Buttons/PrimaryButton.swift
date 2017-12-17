import UIKit

class PrimaryButton: UIButton {
    
    var primaryColor: UIColor?
    var buttonBorderColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundColor: UIColor = primaryColor ?? .green
        let borderColor: UIColor = buttonBorderColor ?? .black
        let buttonFont = "Arial"
        
        layer.backgroundColor = backgroundColor.cgColor
        layer.borderColor = borderColor.cgColor
        layer.shadowColor = borderColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .disabled)
        titleLabel?.font = UIFont(name: buttonFont, size: 24.0)
        titleLabel?.adjustsFontSizeToFitWidth = true        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonHeight = 60.0
        layer.borderWidth = 2.0
        layer.cornerRadius = CGFloat(buttonHeight/2)
        contentHorizontalAlignment = .center
        
    }
}
