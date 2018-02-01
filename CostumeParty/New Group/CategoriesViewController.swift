import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    @IBOutlet weak var category1: PrimaryTextField!
    @IBOutlet weak var category2: PrimaryTextField!
    @IBOutlet weak var category3: PrimaryTextField!
    @IBOutlet weak var category4: PrimaryTextField!
    @IBOutlet weak var category5: PrimaryTextField!
    @IBOutlet weak var category6: PrimaryTextField!
    @IBOutlet weak var category7: PrimaryTextField!
    @IBOutlet weak var category8: PrimaryTextField!
    @IBOutlet weak var category9: PrimaryTextField!
    @IBOutlet weak var category10: PrimaryTextField!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var switch5: UISwitch!
    @IBOutlet weak var switch6: UISwitch!
    @IBOutlet weak var switch7: UISwitch!
    @IBOutlet weak var switch8: UISwitch!
    @IBOutlet weak var switch9: UISwitch!
    @IBOutlet weak var switch10: UISwitch!
    
    var party: Party?
    
    private var categories: [String] = ["ex. Best Costume"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitTapped()
    }
}

extension CategoriesViewController {
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "Next, add some costume categories for your party!\n(Maximum of 10)"
        headingLabel.textColor = .darkTextColor
        
        category1.text = "Best Costume"
        category2.text = "Funniest Costume"
        category3.text = "Best Group Costume"
        
        switch1.isOn = true
        switch2.isOn = true
        switch3.isOn = true
        switch4.isOn = false
        switch5.isOn = false
        switch6.isOn = false
        switch7.isOn = false
        switch8.isOn = false
        switch9.isOn = false
        switch10.isOn = false
        
        submitButton.setTitle("FINISHED", for: .normal)
        submitButton.primaryColor = .affirmativeColor
    }
    
    private func submitTapped() {
        print("SUBMIT TAPPED")
    }
}
