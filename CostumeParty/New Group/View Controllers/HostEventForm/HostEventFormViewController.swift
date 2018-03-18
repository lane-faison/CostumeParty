import UIKit
import FSCalendar

class HostEventFormViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var eventNameField: PrimaryTextField!
    @IBOutlet weak var zipcodeField: PrimaryTextField!
    @IBOutlet weak var pinField: PrimaryTextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateButton: PrimaryButton!
    @IBOutlet weak var nextButton: PrimaryButton!
    
    let user = FirebaseService.firebaseUser()
    
    var eventDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
}

extension HostEventFormViewController {
    @objc func dateButtonTapped() {
        let calendarVC = CalendarViewController()
        calendarVC.calendarDelegate = self
        calendarVC.date = eventDate
        
        navigationController?.pushViewController(calendarVC, animated: false)
    }
    
    @objc func nextButtonTapped() {
        guard let name = eventNameField.text,
            let zipcode = zipcodeField.text,
            let pin = pinField.text else { return }
        
        // Returns a string of only numbers
        let zipNumbersOnly = zipcode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let pinNumbersOnly = pin.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if zipcode.count != 5 || zipcode.count != zipNumbersOnly.count {
            AlertHelper.fireErrorActionSheet(viewController: self, title: "ZIP Code error", message: "Please enter a valid 5-digit ZIP Code")
        } else if pin.count != 4 || pin.count != pinNumbersOnly.count {
            AlertHelper.fireErrorActionSheet(viewController: self, title: "PIN error", message: "Please enter a valid 4-digit PIN")
        } else if !name.isEmpty && !zipcode.isEmpty && !pin.isEmpty {
            guard let eventName = eventNameField.text,
                let eventZipcodeString = zipcodeField.text,
                let zipcode = Int(eventZipcodeString),
                let pinString = pinField.text,
                let pin = Int(pinString),
                let date = eventDate,
                let id = user?.uid else { return }
            
            let event = Event(name: eventName, zipCode: zipcode, hostId: id, date: date, pin: pin)
            let categoryFormVC = CategoryFormViewController(nibName: StoryboardName.categoryForm.rawValue, bundle: nil)
            categoryFormVC.event = event
            
            navigationController?.pushViewController(categoryFormVC, animated: true)
        } else {
            AlertHelper.fireErrorActionSheet(viewController: self, title: "Error", message: "You must complete the form before proceeding.")
        }
    }
}

extension HostEventFormViewController {
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "First, enter in some basic information to better help your guests find your event!"
        headingLabel.textColor = .darkTextColor
        
        eventNameField.fieldLabel.text = "Event name"
        eventNameField.returnKeyType = .next
        eventNameField.tag = 0
        
        zipcodeField.fieldLabel.text = "Event zip code"
        zipcodeField.keyboardType = .numberPad
        zipcodeField.returnKeyType = .next
        zipcodeField.tag = 1
        
        pinField.fieldLabel.text = "Secret 4-digit pin"
        pinField.keyboardType = .numberPad
        pinField.tag = 2
        
        dateLabel.font = .h4
        dateLabel.text = "No date has been set yet"
        
        dateButton.setTitle("SET DATE", for: .normal)
        dateButton.setTitleColor(.lightTextColor, for: .normal)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.lightTextColor, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.isEnabled = false
    }
}

extension HostEventFormViewController: CalendarDelegate {
    func userSelectedDate(_ date: Date) {
        eventDate = date
        if let eventDate = eventDate {
            dateLabel.text = DateHelper.convertDateToStringForDisplay(date: eventDate)
            dateButton.setTitle("CHANGE DATE", for: .normal)
            nextButton.isEnabled = true
        }
    }
}
