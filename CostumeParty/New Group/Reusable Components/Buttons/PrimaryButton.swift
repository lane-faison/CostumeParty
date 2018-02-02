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
    let buttonFont: UIFont = .h4
    
    //Shadow
    var shadowRadius: CGFloat = 3.0
    var shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0)
    
    //Size
    var buttonHeight: CGFloat = 50.0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    @objc open func highlight(_ sender: UIButton) {
        backgroundColor = primaryColor.darkerColor()
        layer.shadowRadius = 0.0
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    @objc open func unhighlight(_ sender: UIButton) {
        backgroundColor = primaryColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }
    
    @objc open func animateTap(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    fileprivate func configure() {
        let cornerRadius = CGFloat(buttonHeight/2)
        
        layer.backgroundColor = primaryColor.cgColor
        layer.shadowColor = primaryColor.darkerColor().darkerColor().cgColor
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        
        setTitleColor(buttonFontColor, for: .normal)
        setTitleColor(buttonFontColor, for: .disabled)
        titleLabel?.font = buttonFont
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        layer.cornerRadius = cornerRadius
        
        addTarget(self, action: #selector(highlight(_:)), for: .touchDown)
        addTarget(self, action: #selector(animateTap(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(unhighlight(_:)), for: .touchUpInside)
    }
}
