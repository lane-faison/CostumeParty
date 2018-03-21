import UIKit

class LobbyButton: UIButton {
    
    var title: String?
    
    init(title: String) {
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
        
        titleLabel?.font = .h5
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
    }
}
