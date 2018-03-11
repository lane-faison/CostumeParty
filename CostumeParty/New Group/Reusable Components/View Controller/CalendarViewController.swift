import UIKit
import FSCalendar

protocol CalendarDelegate {
    func userSelectedDate(_ date: Date)
}

class CalendarViewController: UIViewController {
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.50))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = calendar.bounds.height * 0.01
        calendar.scrollDirection = .horizontal
        return calendar
    }()
    
    var calendarDelegate: CalendarDelegate?
    
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calendar)
        calendar.center = view.center
        
        setupCalendarView()
    }
    
    private func setupCalendarView() {
        view.backgroundColor = UIColor.white.darkerColor()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(donePressed))
        navigationItem.rightBarButtonItem = doneButton
        calendar.select(date)
    }
    
    @objc private func donePressed() {
        navigationController?.popViewController(animated: false)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendarDelegate?.userSelectedDate(date)
    }
}

