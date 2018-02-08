import UIKit

class SquareButton: UIButton {
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
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            sender.backgroundColor = self.primaryColor.darkerColor().darkerColor().darkerColor()
            sender.backgroundColor = self.primaryColor
        }) { Void in() }
    }
    
    fileprivate func configure() {
        layer.backgroundColor = primaryColor.cgColor
        
        setTitleColor(buttonFontColor, for: .normal)
        setTitleColor(buttonFontColor, for: .disabled)
        titleLabel?.font = buttonFont
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.baselineAdjustment = .none
        
        addTarget(self, action: #selector(highlight(_:)), for: .touchDown)
        addTarget(self, action: #selector(unhighlight(_:)), for: .touchUpInside)
    }
}

