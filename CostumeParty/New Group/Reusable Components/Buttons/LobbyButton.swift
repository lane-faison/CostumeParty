import UIKit

class LobbyButton: UIButton {
    
    var title: String?
    
    var image: UIImage?
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
        
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.midX / 2, y: bounds.midY / 3, width: bounds.midX, height: bounds.midY)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleInset: CGFloat = bounds.height / 1.5
        titleEdgeInsets = UIEdgeInsets(top: titleInset, left: 0, bottom: 0, right: 0)
        
        titleLabel?.font = .h5
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.lobbyThemeColor, for: .normal)
        setTitle(title, for: .normal)
        setBackgroundImage(image, for: .normal)
    }
}
