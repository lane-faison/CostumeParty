import UIKit

class PrimaryButton: UIButton {
    //Colors
    var buttonFontColor: UIColor = .white
    var primaryColor: UIColor = .linkColor {
        didSet {
            configure()
        }
    }
    //Font
    var buttonFont: UIFont = .h4 {
        didSet {
            configure()
        }
    }
    //Size
    var buttonHeight: CGFloat = 50.0 {
        didSet {
            configure()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            configure()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    @objc open func highlight(_ sender: UIButton) {
        
    }
    
    @objc open func unhighlight(_ sender: UIButton) {
        animateTap(sender)
    }
    
    private func animateTap(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.05,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    fileprivate func configure() {
        layer.backgroundColor = isEnabled ? primaryColor.cgColor : UIColor.inactiveColor.cgColor
        layer.cornerRadius = buttonHeight/2.0
        
        setTitleColor(buttonFontColor, for: .normal)
        setTitleColor(buttonFontColor, for: .disabled)
        titleLabel?.font = buttonFont
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.baselineAdjustment = .none
        
        addTarget(self, action: #selector(highlight(_:)), for: .touchDown)
        addTarget(self, action: #selector(unhighlight(_:)), for: .touchUpInside)
    }
}
