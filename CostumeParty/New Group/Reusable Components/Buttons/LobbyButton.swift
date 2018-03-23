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
        
        let imageInset: CGFloat = bounds.height / 4
        imageEdgeInsets = UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset)
        
        let image = self.image?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        tintColor = .lobbyThemeColor
        imageView?.contentMode = .scaleAspectFit
    }
}
