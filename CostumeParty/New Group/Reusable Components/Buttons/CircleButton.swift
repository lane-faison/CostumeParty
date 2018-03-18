import UIKit

class CircleButton: UIButton {
    
    var color: UIColor?
    
    var title: String?
    
    init(color: UIColor, title: String) {
        self.color = color
        self.title = title
        
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = color?.cgColor
        layer.cornerRadius = bounds.width / 2
        
        titleLabel?.font = .h5
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
    }
}
