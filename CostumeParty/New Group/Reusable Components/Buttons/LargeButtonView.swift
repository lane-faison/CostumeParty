import UIKit

class LargeButtonView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var primaryColor: UIColor = .linkColor {
        didSet {
            setupView()
        }
    }
    
    override init(frame: CGRect) {   // For using CustomView in code
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {   // For using CustomView in IB
        super.init(coder: aDecoder)

        commonInit()
    }
}

extension LargeButtonView {
    private func commonInit() {
        Bundle.main.loadNibNamed("LargeButtonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        setupView()
    }
    
    private func setupView() {
        contentView.layer.backgroundColor = primaryColor.cgColor
        
        mainImageView.clipsToBounds = true
        mainImageView.layer.borderColor = UIColor.lightTextColor.cgColor
        mainImageView.layer.borderWidth = 2.0
        mainImageView.layer.cornerRadius = mainImageView.frame.height / 2.0
        
        mainLabel.font = UIFont.h3
        mainLabel.textColor = UIColor.lightTextColor
    }
}
