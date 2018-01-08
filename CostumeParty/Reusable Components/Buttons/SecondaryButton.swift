import UIKit

class SecondaryButton: UIButton {
    //Colors
    var primaryColor: UIColor = UIColor.secondaryLightColor
    var buttonFontColor: UIColor = UIColor.secondaryTextColor
    
    //Font
    let buttonFont: UIFont = .h3
    
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
        addTarget(self, action: #selector(unhighlight(_:)), for: .touchUpInside)
    }
}
