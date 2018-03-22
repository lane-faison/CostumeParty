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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let inset: CGFloat = frame.height * 0.30
        
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 20.0, right: 20.0)
        
        setImage(image, for: .normal)
        
        titleLabel?.font = .h5
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.lobbyThemeColor, for: .normal)
        setTitle(title, for: .normal)
    }
}
