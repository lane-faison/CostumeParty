import UIKit

class LargeButtonView: UIView {
    
    @IBOutlet var contentView: LargeButtonView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var primaryColor: UIColor = .linkColor
    
//    override init(frame: CGRect) {   // For using CustomView in code
//        super.init(frame: frame)
//
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {   // For using CustomView in IB
//        super.init(coder: aDecoder)
//
//        commonInit()
//    }
//
    override func awakeFromNib() {
        super.awakeFromNib()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension LargeButtonView {
    private func commonInit() {
        Bundle.main.loadNibNamed(StoryboardName.largeButtonView.rawValue, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupView()
    }
    
    private func setupView() {
        layer.backgroundColor = primaryColor.cgColor
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
    }
}
