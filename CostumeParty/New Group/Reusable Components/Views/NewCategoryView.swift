import UIKit

class NewCategoryView: UIView {

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var categoryField: PrimaryTextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    private var isSelected = false {
        didSet {
            plusButton.setTitleColor(.lightTextColor, for: .normal)
            plusButton.layer.cornerRadius = 15
            
            if isSelected {
                plusButton.backgroundColor = .red
                plusButton.setTitle("-", for: .normal)
                categoryField.isHidden = true
                categoryLabel.isHidden = false
            } else {
                plusButton.backgroundColor = .green
                plusButton.setTitle("+", for: .normal)
                categoryField.isHidden = false
                categoryLabel.isHidden = true
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        setupView()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
}

extension NewCategoryView {
    @objc private func plusButtonTapped() {
        isSelected = !isSelected
    }
    
    private func setupView() {
//        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
}
