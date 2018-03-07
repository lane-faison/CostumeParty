import UIKit

class CircleButton: UIButton {
    
    var color: UIColor?
    
    var image: UIImage?
    
    init(color: UIColor, image: UIImage?) {
        self.color = color
        self.image = image
        
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
        imageView?.tintColor = .white
        imageView?.contentMode = .scaleAspectFit
        setImage(image, for: .normal)
    }
}
